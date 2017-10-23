//
//  LawbreakerInfo.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 20/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class LawbreakerInfo: NSObject {

    // MARK: - 自定义属性
    @objc var carId: String?                      //车牌号
    @objc var carName: String?                    //车品牌
    @objc var carColor: String?                   //车颜色
    @objc var carOwnerId: String?                 //车主身份证号码
    @objc var carOwnerName: String?               //车主姓名
    @objc var carOwnerSex: NSInteger = 0          //车主性别
    @objc var carOwnerPhoneNumber: String?        //车主电话号码
    @objc var lawbreakerInfoId: NSInteger = 0     //违法信息编号
    @objc var lawbreakerInfo: String?             //违法信息内容
    
    init(dict: [String : Any]) {
        super.init()
        print(dict)
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
