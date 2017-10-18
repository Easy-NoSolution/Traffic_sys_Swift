//
//  Log.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 16/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class Log: NSObject {
    
    // MARK: - 自定义属性
    @objc var loginDate: NSString?               //登录日期
    @objc var logoutDate: NSString?              //退出日期
    
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
