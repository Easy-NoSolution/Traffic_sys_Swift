//
//  UIColor-Extension.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 21/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

extension UIColor {
    static func colorWithHex(hex: NSInteger, alpha: CGFloat) -> UIColor {
        let rUInt8Color = UInt8((hex >> 16) & 255)
        let gUInt8Color = UInt8((hex >> 8) & 255)
        let bUInt8Color = UInt8(hex & 255)
        let rCGFloatColor = CGFloat(rUInt8Color)
        let gCGFloatColor = CGFloat(gUInt8Color)
        let bCGFloatColor = CGFloat(bUInt8Color)
        
        return UIColor(red: rCGFloatColor / 255.0, green: gCGFloatColor / 255.0, blue: bCGFloatColor / 255.0, alpha: alpha)
    }
}
