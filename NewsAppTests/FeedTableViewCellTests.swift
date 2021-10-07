//
//  FeedTableViewCellTests.swift
//  NewsAppTests
//
//  Created by Ingvar on 06.10.2021.
//

import XCTest
@testable import NewsApp

class FeedTableViewCellTests: XCTestCase {

    var cell: FeedTableViewCell!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: NewsFeedViewController.self)) as! NewsFeedViewController
        controller.loadViewIfNeeded()
        
        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        tableView?.dataSource = dataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: String(describing: FeedTableViewCell.self), for: IndexPath(row: 0, section: 0)) as? FeedTableViewCell
    }

    override func tearDown() {
    }
    
    func testCellHasTitleLabel() {
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func testCellHasTitleLabelInContentView() {
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellHasDescriptionLabel() {
        XCTAssertNotNil(cell.descriptionLabel)
    }
    
    func testCellHasDescriptionLabelInContentView() {
        XCTAssertTrue(cell.descriptionLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellHasImageFeed() {
        XCTAssertNotNil(cell.imageFeed)
    }
    
    func testCellHasImageFeedInContentView() {
        XCTAssertTrue(cell.imageFeed.isDescendant(of: cell.contentView))
    }
    
    func testConfigureSetsTitle() {
        let article = NewsSource.Article(title: "Test Title")
         
        cell.configure(withArticle: article)
        
        XCTAssertEqual(cell.titleLabel.text, article.title)
    }
    
    func testConfigureSetsDescription() {
        let article = NewsSource.Article(description: "Test Description")
         
        cell.configure(withArticle: article)
        
        XCTAssertEqual(cell.descriptionLabel.text, article.description)
    }
    
    func testConfigureSetsAuthor() {
        let article = NewsSource.Article(author: "Test Author")
         
        cell.configure(withArticle: article)
        
        XCTAssertEqual(cell.authorLabel.text, article.author)
    }
    
}

extension FeedTableViewCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}


