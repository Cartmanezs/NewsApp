//
//  ViewController.swift
//  NewsApp
//
//  Created by Ingvar on 15.04.2021.
//

import UIKit
import SDWebImage

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let feedCellId = "FeedTableViewCell"
    private var dataFetcherService = DataFetcherService()
    private var myFeed: [NewsSource.Article?] = []
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredData: [NewsSource.Article?] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName:feedCellId, bundle: nil), forCellReuseIdentifier: feedCellId)
        tableView.separatorColor = UIColor.clear
        
        configureSearch()
        fetchTopHeadlines()
    }
    
    private func fetchTopHeadlines() {
        dataFetcherService.fetchTopHeadLines { [weak self] (myFeed) in
            guard let `self` = self, let myFeed = myFeed?.articles else { return }
            self.myFeed = myFeed
            self.filteredData = myFeed
            self.tableView.reloadData()
        }
    }
    
    private func setImage(from url: URL ,feedImage: UIImageView) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                feedImage.image = UIImage(data: data)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

extension NewsFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredData.count
        }
        return myFeed.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: feedCellId, for: indexPath) as! FeedTableViewCell
        let articles: NewsSource.Article?
        if !isFiltering {
            articles = self.myFeed[indexPath.row]
        } else {
            articles = self.filteredData[indexPath.row]
        }
        if let articles = articles {
            cell.configure(withArticle: articles)
            cell.activityView.isHidden = false 
            cell.activityView.startAnimating()
            if articles.urlToImage != nil {
                setImage(from: (articles.urlToImage!), feedImage: cell.imageFeed!)
                cell.activityView.stopAnimating()
            }
            cell.activityView.isHidden = true
        }
        
        return cell
    }
}

extension NewsFeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let url: URL?
        if !isFiltering {
            url = myFeed[indexPath.row]?.url
        } else {
            url = filteredData[indexPath.row]?.url
        }
        if url != nil {
            vc.url = url
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension NewsFeedViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func configureSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
    }
    
    private func filterContentForSearchText(_ searchText: String ) {
        filteredData = myFeed.filter { (article: NewsSource.Article?) -> Bool in
            return (article?.title!.lowercased().contains(searchText.lowercased()))!
        }
        tableView.reloadData()
    }
}
