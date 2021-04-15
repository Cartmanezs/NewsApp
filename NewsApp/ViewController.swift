//
//  ViewController.swift
//  NewsApp
//
//  Created by Ingvar on 15.04.2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let feedCellId = "FeedTableViewCell"
    private var dataFetcherService = DataFetcherService()
    private var myFeed: [NewsSource.Article?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName:feedCellId, bundle: nil), forCellReuseIdentifier: feedCellId)
        tableView.separatorColor = UIColor.clear
        
        dataFetcherService.fetchTopHeadLines { [weak self] (myFeed) in
            guard let `self` = self, let myFeed = myFeed?.articles else { return }
            self.myFeed = myFeed
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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFeed.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: feedCellId, for: indexPath) as! FeedTableViewCell
        if let feed = self.myFeed[indexPath.row] {
            cell.titleLabel.text = feed.title
            cell.sourceLabel.text = feed.source.name
            cell.authorLabel.text = feed.author
            cell.descriptionLabel.text = feed.description
            setImage(from: feed.urlToImage!, feedImage: cell.imageView!)
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


