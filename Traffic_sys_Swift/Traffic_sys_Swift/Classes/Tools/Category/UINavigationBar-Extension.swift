//
//  UINavigationBar-Extension.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 21/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func setColor(color: UIColor) {
        let view = UIView(frame: CGRect(x: 0, y: -20, width: self.bounds.width, height: 64))
        view.backgroundColor = color
        view.isUserInteractionEnabled = false
        
        setValue(view, forKey: "backgroundView")
    }
}

