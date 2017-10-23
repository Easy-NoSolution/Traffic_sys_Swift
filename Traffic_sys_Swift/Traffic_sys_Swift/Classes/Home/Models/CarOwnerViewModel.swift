//
//  CarOwnerViewModel.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 20/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit
import SDWebImage

class CarOwnerViewModel: NSObject {

    // MARK: - 自定义属性
    var carOwner: CarOwner?
    var carOwnerSex: String? {
        if carOwner?.carOwnerSex == 0 {
            return "男"
        } else {
            return "女"
        }
    }
    var carOwnerBirthday: String? {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        fmt.locale = Locale(identifier: "Asia/Shanghai")
        return fmt.string(from: Date(timeIntervalSince1970: (carOwner?.carOwnerBirthday)!))
    }
    var carOwnerAvatarUrl: URL? {
        let urlStr = "http://39.108.237.44" + (carOwner?.carOwnerAvatar)!
        SDImageCache.shared().removeImage(forKey: urlStr, withCompletion: nil) //清除之前的图片缓存
        return URL(string: urlStr);
    }
    
    init(carOwner: CarOwner) {
        super.init()
        
        self.carOwner = carOwner
    }
}
