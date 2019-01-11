//
//  AppListTableViewCell.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import Kingfisher

class AppListTableViewCell: UITableViewCell {

    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        appIconImageView.layer.cornerRadius = 10
        appIconImageView.layer.masksToBounds = true
    }

    func bindData(appModel: AppModel) {
        guard let url = URL(string: appModel.iconURLString) else { return }
        appIconImageView.kf.setImage(with: url)
        appNameLabel.text = appModel.appName
    }
}
