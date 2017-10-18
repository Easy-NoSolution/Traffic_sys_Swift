//
//  LogViewModel.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 16/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class LogViewModel: NSObject {

    // MARK: - 自定义属性
    var log:Log?
    
    // MARK: - 计算属性
    var loginDate: String? {
        guard let date = log?.loginDate else {
            return nil
        }
        
        let fmt: DateFormatter = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd hh:mm:ss"
        fmt.locale = Locale(identifier: "zh_Hans_CN")
        fmt.timeZone = TimeZone(identifier: "Asia/Shanghai")
        return fmt.string(from: Date(timeIntervalSince1970: TimeInterval(date.floatValue)))
    }
    var logoutDate: String? {
        guard let date = log?.logoutDate else {
            return nil
        }
        
        let fmt: DateFormatter = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd hh:mm:ss"
        fmt.locale = Locale(identifier: "zh_Hans_CN")
        fmt.timeZone = TimeZone(identifier: "Asia/Shanghai")
        return fmt.string(from: Date(timeIntervalSince1970: TimeInterval(date.floatValue)))
    }
    
    init(log: Log) {
        super.init()
        
        self.log = log
    }
}
