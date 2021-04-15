//
//  ViewController.swift
//  NewsApp
//
//  Created by Ingvar on 15.04.2021.
//

import UIKit

class ViewController: UIViewController {

    private var dataFetcherService = DataFetcherService()
    var myFeed: [NewsSource.Article?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataFetcherService.fetchTopHeadLines { [weak self] (myFeed) in
            guard let `self` = self, let myFeed = myFeed?.articles else { return }
            self.myFeed = myFeed
        }
    }


}

