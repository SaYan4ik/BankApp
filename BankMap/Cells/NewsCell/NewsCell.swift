//
//  NewsCell.swift
//  BankMap
//
//  Created by Александр Янчик on 24.01.23.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleNewsLabel: UILabel!
    @IBOutlet weak var newsTextView: UITextView!
    
    static var id = String(describing: NewsCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(news: NewsModel) {
        self.titleNewsLabel.text = news.nameRu
//        self.newsTextView.attributedText = news.htmlRu.htmlToAttributedString
        newsImageView.sd_setImage(with: URL(string: news.imgURL))
    }
}
