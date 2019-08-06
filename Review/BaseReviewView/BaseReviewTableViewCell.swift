//
//  BaseReviewTableViewCell.swift
//  Review
//
//  Created by Wenslow on 2019/1/4.
//  Copyright © 2019 Wenslow. All rights reserved.
//

import UIKit
import Cosmos
import AppStoreReviewService

class BaseReviewTableViewCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontKit.labelFont.value
        return label
    }()
    let ratingView: CosmosView = {
        let view = CosmosView(settings: CosmosSettings.default)
        return view
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = FontKit.nameLabelFont.value
        label.textAlignment = .right
        label.textColor = ColorKit.nameLabelColor.value
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = FontKit.reviewContentFont.value
        label.numberOfLines = 0
        return label
    }()
    lazy var reviewCardView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorKit.reviewCardBackgroundColor.value
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let viewMargin: CGFloat = 25
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.addSubview(reviewCardView)
        reviewCardView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(viewMargin)
            make.top.bottom.equalToSuperview().inset(15)
        }
        
        reviewCardView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(15)
        }
        
        reviewCardView.addSubview(ratingView)
        ratingView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).inset(-10)
            make.left.equalTo(titleLabel)
            make.size.equalTo(CGSize(width: 129, height: 24))
        }
        
        reviewCardView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(ratingView)
            make.right.equalTo(titleLabel)
            make.left.equalTo(ratingView.snp.right).inset(10)
        }
        
        reviewCardView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ratingView.snp.bottom).inset(-15)
            make.left.bottom.right.equalToSuperview().inset(15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(reviewModel: ReviewModel) {
        titleLabel.text = reviewModel.title
        nameLabel.text = reviewModel.author
        ratingView.rating = reviewModel.rating
        contentLabel.text = reviewModel.content
    }
}
