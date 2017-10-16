//
//  RegexTool.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 13/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class RegexTool: NSObject {

    static func isQualified(text: String, pattern: String) -> Bool {
        
//        1.创建正则表达式
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        
//        2.获取匹配结果
        let results = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count))
        
//        3.验证结果
        if results.count == 0 {
            return false
        } else {
            return true
        }
//        for result in results {
//            print((userId as NSString).substring(with: result.range))
//            print("(\(result.range.location), \(result.range.length))")
//        }
    }
    
}
