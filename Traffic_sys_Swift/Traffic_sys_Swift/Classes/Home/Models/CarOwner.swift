//
//  CarOwner.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 20/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class CarOwner: NSObject {

    // MARK: - 自定义属性
    @objc var carOwnerId: String?                             //车主身份证
    @objc var carOwnerName: String?                           //车主名
    @objc var carOwnerSex: NSInteger = 0                        //车主性别
    @objc var carOwnerBirthday: TimeInterval = 0.0              //车主出生日期
    @objc var carOwnerAddress: String?                        //车主住址
    @objc var carOwnerPhoneNumber: String?                    //车主电话号码
    @objc var carOwnerAvatar: String?                         //车主头像
    
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
