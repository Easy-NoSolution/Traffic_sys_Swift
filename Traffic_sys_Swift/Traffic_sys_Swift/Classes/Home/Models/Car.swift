//
//  Car.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 20/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class Car: NSObject {

    // MARK: - 自定义属性
    @objc var carId: String?                      //车牌号
    @objc var carName: String?                    //车品牌
    @objc var carColor: String?                   //车颜色
    @objc var carOwnerId: String?                 //车主身份证号码
    
    init(dict: [String : Any]) {
        super.init()
        print(dict)
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
