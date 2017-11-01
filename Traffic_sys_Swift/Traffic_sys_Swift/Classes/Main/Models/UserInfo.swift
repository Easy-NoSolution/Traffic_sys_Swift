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
//    解档
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
//        1.获取所有属性
//        1.1.创建保存属性个数的变量
        var count: UInt32 = 0
//        1.2.获取变量的指针
        let outCount = withUnsafeMutablePointer(to: &count) { (outCount: UnsafeMutablePointer<UInt32>) -> UnsafeMutablePointer<UInt32> in
            return outCount
        }
//        1.3.获取属性数组
        let ivars = class_copyIvarList(UserInfo.self, outCount)
        
        for i in 0..<count {
//            2.获取键值对
//            2.1.获取ivars中的值
            let ivar = ivars![Int(i)]
//            2.2.获取键
            let ivarKey = String(cString: ivar_getName(ivar)!)
//            2.3.获取值
            let ivarValue = aDecoder.decodeObject(forKey: ivarKey)
            
//            3.设置属性的值
            setValue(ivarValue, forKey: ivarKey)
        }
        
//        4.释放内存
        free(ivars)
    }
    
//    归档
    func encode(with aCoder: NSCoder) {
        
//        1.获取所有属性
//        1.1.创建保存属性个数的变量
        var count: UInt32 = 0
//        1.2.获取变量的指针
        let outCount = withUnsafeMutablePointer(to: &count) { (outCount: UnsafeMutablePointer<UInt32>) -> UnsafeMutablePointer<UInt32> in
            return outCount
        }
//        1.3.获取属性数组
        let ivars = class_copyIvarList(UserInfo.self, outCount)
        
        for i in 0..<count {
//            2.获取键值对
//            2.1.获取ivars中的值
            let ivar = ivars![Int(i)]
//            2.2.获取键
            let ivarKey = String(cString: ivar_getName(ivar)!)
//            2.3.获取值
            let ivarValue = value(forKey: ivarKey)
            
//            3.归档
            aCoder.encode(ivarValue, forKey: ivarKey)
        }
        
//        4.释放内存
        free(ivars)
    }
}
