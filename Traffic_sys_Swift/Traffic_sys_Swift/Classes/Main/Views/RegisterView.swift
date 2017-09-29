//
//  RegisterView.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 22/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class RegisterView: UIView {

    // MARK: - 自定义属性
    var titleLabel = UILabel() {
        didSet {
            titleLabel.sizeToFit()
        }
    }
    lazy var valueTextField = UITextField()
    lazy var underLine = UIView()
    lazy var sexSelector = UISegmentedControl()
    
    // MARK: - 系统回调函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI界面
extension RegisterView {
    
    func setupUIView() {
//        1.添加控件
        addSubview(titleLabel)
        addSubview(valueTextField)
        addSubview(underLine)
        addSubview(sexSelector)
        
//        2.设置frame
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.height.equalTo(17)
            make.width.lessThanOrEqualTo(90)
        }
        valueTextField.snp.makeConstraints { (make) in
            make.top.right.equalTo(0)
            make.left.equalTo(titleLabel.snp.right)
            make.height.equalTo(17)
        }
        underLine.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(1)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
        sexSelector.snp.makeConstraints { (make) in
            make.right.equalTo(-2)
            make.height.equalTo(17)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(70)
        }
        
//        3.设置属性
        titleLabel.textColor = UIColor.colorWithHex(hex: kTextColor, alpha: 1)
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "font14", size: 14)
        
        underLine.backgroundColor = UIColor.colorWithHex(hex: kTextColor, alpha: 1)
        
        sexSelector.insertSegment(withTitle: "男", at: 0, animated: false)
        sexSelector.insertSegment(withTitle: "女", at: 1, animated: false)
        sexSelector.selectedSegmentIndex = 0
        sexSelector.isHidden = true
    }
}
