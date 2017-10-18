//
//  TextView.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 17/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class TextView: UITextView {

    // MARK: - 自定义属性
    lazy var placeholder: UILabel = UILabel()
    var placeholderFont: UIFont? {
        didSet {
            placeholder.font = placeholderFont
        }
    }
    var placeholderColor: UIColor? {
        didSet {
            placeholder.textColor = placeholderColor
        }
    }

    // MARK: - 系统回调函数
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        placeholderColor = UIColor.lightText
        super.init(frame: frame, textContainer: textContainer)
        
        setupView()
        setupNotification()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
}

// MARK: - 设置UI界面
extension TextView {
    
    func setupView() {
        
//        1.添加控件
        addSubview(placeholder)
        
//        2.设置frame
        placeholder.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(4)
            make.right.bottom.equalTo(0)
        }
        
//        3.设置属性
        
    }
}

// MARK: - 设置通知
extension TextView {
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(textChange(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
}

// MARK: - 事件监听函数
extension TextView {
    
    @objc func textChange(_ notification: Notification) {
        placeholder.isHidden = (text.characters.count != 0)
    }
    
}
