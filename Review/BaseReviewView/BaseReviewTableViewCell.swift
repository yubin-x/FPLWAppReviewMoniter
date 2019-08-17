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
import ReviewUIKit

class BaseReviewTableViewCell: UITableViewCell {

    lazy var portraitImageView = ImageViews.portraitImageView()
    lazy var nameLabel: UILabel = Labels.userNameLabel()
    lazy var versionLabel: UILabel = Labels.grayH2Label()
    lazy var ratingView: RatingView = RatingView.fiveStartRatingView()
    
    lazy var contentLabel: UILabel = {
        let label = Labels.h2Label()
        label.numberOfLines = 0
        return label
    }()
    lazy var reviewCardView: UIView = Views.cardContentView()
    
    private let viewMargin: CGFloat = 10
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.addSubview(reviewCardView)
        reviewCardView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(viewMargin)
            make.top.bottom.equalToSuperview().inset(7)
        }
        
        reviewCardView.addSubview(portraitImageView)
        portraitImageView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(15)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        reviewCardView.addSubview(versionLabel)
        versionLabel.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(18)
            make.width.equalTo(50)
        }
        
        reviewCardView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(portraitImageView).inset(3)
            make.left.equalTo(portraitImageView.snp.right).inset(-10)
            make.right.equalTo(versionLabel.snp.left).inset(-10)
        }
        
        reviewCardView.addSubview(ratingView)
        ratingView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).inset(-2)
            make.left.equalTo(nameLabel)
            make.size.equalTo(CGSize(width: 100, height: 15))
        }

        reviewCardView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ratingView.snp.bottom).inset(-10)
            make.left.bottom.right.equalToSuperview().inset(15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(reviewModel: ReviewModel) {
        versionLabel.text = reviewModel.version
        nameLabel.text = reviewModel.author
        ratingView.rating = reviewModel.rating
        portraitImageView.image = UIImage(named: reviewModel.portraitImageName)
        
        let attributedText = NSMutableAttributedString(string: reviewModel.title,
                                                  attributes: [NSAttributedString.Key.font: FontKit.reviewTitleFont.value])
        let contentText = NSAttributedString(string: reviewModel.content,
                                             attributes: [NSAttributedString.Key.font: FontKit.reviewContentFont.value])
        attributedText.append(NSAttributedString(string: "  "))
        attributedText.append(contentText)
        
        contentLabel.attributedText = attributedText
    }
}
