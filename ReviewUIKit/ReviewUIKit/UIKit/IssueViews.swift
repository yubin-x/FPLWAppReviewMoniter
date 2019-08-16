//
//  IssueViews.swift
//  ReviewUIKit
//
//  Created by 朱廷 on 2019/8/16.
//  Copyright © 2019 朱廷. All rights reserved.
//

import UIKit
import SnapKit

public struct IssueViews {
    public static func errorView() -> IssueBaseView {
        let view = IssueBaseView()
        view.imageView.image = ImageKit.error.value
        view.titleLabel.text = "Oops!"
        view.contentLabel.text = "Something went wrong, \nplease try again"
        view.functionButton.setTitle("Retry", for: UIControl.State.normal)
        return view
    }
    
    public static func noResultView() -> IssueBaseView {
        let view = IssueBaseView()
        view.imageView.image = ImageKit.noResult.value
        view.titleLabel.text = "No results found"
        view.contentLabel.text = "Try adjusting your search \nto find what you are looking for"
        view.functionButton.isHidden = true
        return view
    }
}

public class IssueBaseView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = Labels.boldLabel()
        label.textAlignment = .center
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = Labels.h2Label()
        label.textAlignment = .center
        return label
    }()
    lazy var functionButton = Buttons.functionButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(functionButton)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.size.equalTo(CGSize(width: 250, height: 200))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(340)
        }
        
        functionButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).inset(-30)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 290, height: 55))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
