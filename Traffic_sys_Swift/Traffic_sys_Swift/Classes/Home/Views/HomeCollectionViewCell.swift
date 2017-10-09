//
//  HomeCollectionViewCell.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 30/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - 自定义属性
    lazy var imageView: UIImageView = UIImageView()
    lazy var titleLabel: UILabel = UILabel()
    
    // MARK: - 系统回调函数
    override init(frame: CGRect) {
        super.init(frame: frame)

//        1.添加控件
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)

//        2.设置frame
        imageView.snp.makeConstraints { (make) in
            make.top.top.left.right.equalTo(0)
            make.height.equalTo(56)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.left.right.equalTo(0)
        }

//        3.设置属性
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "HomeFont", size: 14.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
