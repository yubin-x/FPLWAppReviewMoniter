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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(entryModel: EntryModel) {
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
