//
//  UserInfo.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 29/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class UserInfo: NSObject, NSCoding {

    // MARK: - 自定义属性
    @objc var userId: String?                               //用户id
    @objc var username: String?                             //用户名
    @objc var userSex : NSInteger = 0                       //用户性别
    @objc var userBirthday: TimeInterval = 0.0              //用户出生日期
    @objc var userAvatar: String?                           //用户头像URLStr
    @objc var password: String?                             //用户密码
    
    init(dict: [String : Any]) {
        super.init()
        
        self.setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["userId", "username", "userSex", "userBirthday", "userAvatar", "password"]).description
    }
    
    // MARK: - 归档和解档
//    归档
    required init?(coder aDecoder: NSCoder) {
        userId = aDecoder.decodeObject(forKey: "userId") as? String
        username = aDecoder.decodeObject(forKey: "username") as? String
        userSex = aDecoder.decodeInteger(forKey: "userSex")
        userBirthday = aDecoder.decodeDouble(forKey: "userBirthday")
        userAvatar = aDecoder.decodeObject(forKey: "userAvatar") as? String
        password = aDecoder.decodeObject(forKey: "password") as? String
    }
    
//    解档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(userSex, forKey: "userSex")
        aCoder.encode(userBirthday, forKey: "userBirthday")
        aCoder.encode(userAvatar, forKey: "userAvatar")
        aCoder.encode(password, forKey: "password")
    }
}
