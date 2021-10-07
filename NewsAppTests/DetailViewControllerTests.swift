//
//  DetailViewControllerTests.swift
//  NewsAppTests
//
//  Created by Ingvar on 07.10.2021.
//

import XCTest
@testable import NewsApp

class DetailViewControllerTests: XCTestCase {

    var controller: DetailViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController
        controller.loadViewIfNeeded()
    }

    override func tearDown() {
    }

    func testHasWebView () {
        XCTAssertNotNil(controller.webView)
        XCTAssertNotNil(controller.webView.isDescendant(of: controller.view))
    }

}
