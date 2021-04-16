//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Ingvar on 16.04.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    var testIndex = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = testIndex
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
