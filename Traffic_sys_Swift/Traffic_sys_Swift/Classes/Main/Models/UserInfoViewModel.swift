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
    
    // MARK: - 计算属性
    var userInfoPath: String {
        let userInfoPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (userInfoPath as NSString).strings(byAppendingPaths: ["userInfo.plist"]).first!
    }
    
    // MARK: - 重写init方法
    override init() {
        super.init()
//        从沙盒中读取数据
        userInfo = NSKeyedUnarchiver.unarchiveObject(withFile: userInfoPath) as? UserInfo
    }
}
