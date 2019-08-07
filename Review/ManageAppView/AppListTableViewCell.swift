//
//  AppListTableViewCell.swift
//  Review
//
//  Created by Wenslow on 2019/1/11.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import Kingfisher
import ReviewUIKit
import AppStoreReviewService

class AppListTableViewCell: UITableViewCell {

    lazy var appIconImageView: UIImageView = ImageViews.appICONImageView()
    lazy var appNameLabel: UILabel = Labels.h1Label()
    lazy var ratingView: RatingView = RatingView.quickInit()
    lazy var averageRatingLabel: UILabel = Labels.h2Label()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    func configUI() {
        contentView.addSubview(appIconImageView)
        contentView.addSubview(appNameLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(averageRatingLabel)
        
        appIconImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview().inset(20)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        appNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(appIconImageView)
            make.left.equalTo(appIconImageView.snp.right).inset(-20)
            make.right.equalToSuperview().inset(25)
        }
        ratingView.snp.makeConstraints { (make) in
            make.bottom.equalTo(appIconImageView)
            make.left.equalTo(appNameLabel)
            make.size.equalTo(CGSize(width: 129, height: 24))
        }
        averageRatingLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(ratingView)
            make.left.equalTo(ratingView.snp.right).inset(-10)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(appModel: AppInfoModel) {
        appNameLabel.text = appModel.appName
        ratingView.rating = appModel.averageUserRating ?? 0
        averageRatingLabel.text = String(appModel.averageUserRating ?? 0)
        guard let url = URL(string: appModel.iconURLString) else { return }
        appIconImageView.kf.setImage(with: url)
    }
}
