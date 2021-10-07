//
//  FeedTableViewCell.swift
//  NewsApp
//
//  Created by Ingvar on 15.04.2021.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var imageFeed: UIImageView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(withArticle article: NewsSource.Article) {
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.description
        self.authorLabel.text = article.author
        self.sourceLabel.text = article.source?.name
    }

}
