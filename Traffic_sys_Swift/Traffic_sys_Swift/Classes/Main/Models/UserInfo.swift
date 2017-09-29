//
//  UserInfo.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 29/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class UserInfo: NSObject {

    @objc var userId: String?                               //用户id
    @objc var username: String?                             //用户名
    @objc var userSex : NSInteger = 0                       //用户性别
    @objc var userBirthday: String?                         //用户出生日期
    @objc var userAvatar: String?                           //用户头像URL
    @objc var password: String?                             //用户密码
    
    init(dict: [String : Any]) {
        super.init()
        
        self.setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["userId", "username", "userSex", "userBirthday", "password"]).description
    }
}