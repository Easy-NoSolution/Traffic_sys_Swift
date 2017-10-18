//
//  TextField.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 18/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class TextField: UITextField {

    // MARK: - 系统回调函数
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0.0, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width / 2, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }

}
