//
//  UIButton-Extension.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 17/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

// MARK: - 自定义函数
extension UIButton {
    func setupBtnProperty(viewController: UIViewController, action: Selector, bgColor: UIColor, title: String) {

        backgroundColor = bgColor
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        addTarget(viewController, action: action, for: .touchUpInside)
    }
}
