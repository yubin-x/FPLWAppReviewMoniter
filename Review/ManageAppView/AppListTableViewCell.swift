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
import StoreKit

class AppListTableViewCell: UITableViewCell {

    lazy var appIconImageView: UIImageView = ImageViews.appICONImageView()
    lazy var appNameLabel: UILabel = Labels.h1Label()
    lazy var genresLabel: UILabel = Labels.grayH2Label()
    lazy var artistNameLabel: UILabel = {
        let label = Labels.grayH2Label()
        label.textAlignment = .left
        return label
    }()
    lazy var ratingView: RatingView = RatingView.oneStartRatingView()
    lazy var averageRatingLabel: UILabel = Labels.grayH2Label()
    lazy var seperateView: UIView = Views.seperateView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    func configUI() {
        contentView.addSubview(appIconImageView)
        contentView.addSubview(appNameLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(averageRatingLabel)
        contentView.addSubview(seperateView)
        
        appIconImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview().inset(15)
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        appNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(appIconImageView)
            make.left.equalTo(appIconImageView.snp.right).inset(-15)
            make.right.equalToSuperview().inset(20)
        }
        genresLabel.snp.makeConstraints { (make) in
            make.left.equalTo(appNameLabel)
            make.top.equalTo(appNameLabel.snp.bottom).inset(-5)
        }
        averageRatingLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(genresLabel)
            make.left.equalTo(genresLabel.snp.right).inset(-10)
        }
        ratingView.snp.makeConstraints { (make) in
            make.centerY.equalTo(averageRatingLabel)
            make.left.equalTo(averageRatingLabel.snp.right).inset(-3)
            make.size.equalTo(CGSize(width: 100, height: 15))
        }
        artistNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(appNameLabel)
            make.top.equalTo(genresLabel.snp.bottom).inset(-5)
            make.right.equalTo(appNameLabel)
        }
        seperateView.snp.makeConstraints { (make) in
            make.left.equalTo(appIconImageView)
            make.right.equalTo(appNameLabel)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(appModel: AppInfoModel) {
        appNameLabel.text = appModel.appName
        genresLabel.text = appModel.genres.joined(separator: ", ")
        artistNameLabel.text = appModel.artistName
        ratingView.rating = appModel.averageUserRating ?? 0
        averageRatingLabel.text = String(appModel.averageUserRating ?? 0)
        guard let url = URL(string: appModel.iconURLString) else { return }
        appIconImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
    }
}
