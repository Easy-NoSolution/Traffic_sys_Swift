//
//  LawbreakerInfoViewModel.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 20/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class LawbreakerInfoViewModel: NSObject {

    // MARK: - 自定义属性
    var lawbreakerInfo: LawbreakerInfo?
    var carOwnerSex: String? {
        if lawbreakerInfo?.carOwnerSex == 0 {
            return "男"
        } else {
            return "女"
        }
    }
    
    init(lawbreakerInfo: LawbreakerInfo) {
        super.init()
        
        self.lawbreakerInfo = lawbreakerInfo
    }
}
