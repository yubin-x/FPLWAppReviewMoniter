//
//  BaseReviewTableViewCell.swift
//  Review
//
//  Created by Wenslow on 2019/1/4.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import Cosmos

class BaseReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var grayView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        grayView.layer.cornerRadius = 10
        grayView.layer.masksToBounds = true
    }
    
    func bindData(entryModel: ReviewModel) {
        titleLabel.text = entryModel.title.label
        nameLabel.text = entryModel.author.name.label
        if let rating = Double(entryModel.rating.label) {
            ratingView.rating = rating
        } else {
            ratingView.rating = 0
        }
        contentLabel.text = entryModel.content.label
    }
}
