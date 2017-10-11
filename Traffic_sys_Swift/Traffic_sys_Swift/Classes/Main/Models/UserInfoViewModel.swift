//
//  UserInfoViewModel.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 09/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class UserInfoViewModel: NSObject {

    // MARK: - 将类设计成单例
    static let shareInstance: UserInfoViewModel = UserInfoViewModel()

    // MARK: - 自定义属性
    var userInfo: UserInfo?
    var userSex: String? {
        if userInfo?.userSex == 0 {
            return "男"
        } else {
            return "女"
        }
    }
    var userBithday: String? {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        fmt.locale = Locale(identifier: "Asia/Shanghai")
        return fmt.string(from: Date(timeIntervalSince1970: (userInfo?.userBirthday)!))
    }
    var userAvatarUrl: URL? {
        let urlStr = "http://39.108.237.44" + (userInfo?.userAvatar)!
        return URL(string: urlStr);
    }
    
    // MARK: - 计算属性
    static var userInfoPath: String {
        let userInfoPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (userInfoPath as NSString).strings(byAppendingPaths: ["userInfo.plist"]).first!
    }
    
    // MARK: - 重写init方法
    override init() {
        super.init()
        
//        1.从沙盒中获取用户信息
        userInfo = NSKeyedUnarchiver.unarchiveObject(withFile: UserInfoViewModel.userInfoPath) as? UserInfo;
    }
}
