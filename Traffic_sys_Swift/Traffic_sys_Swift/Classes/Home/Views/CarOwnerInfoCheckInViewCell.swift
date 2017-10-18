//
//  CarOwnerInfoCheckInViewCell.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 17/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class CarOwnerInfoCheckInViewCell: HomeViewCell {

    // MARK: - 系统回调函数
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        valueLabel.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - 外部接口
extension CarOwnerInfoCheckInViewCell {
    
    static func checkInCellWithTableView(tableView: UITableView) -> UITableViewCell? {
        let kCarOwnerInfoCheckInViewCellIdentifier = "CarOwnerInfoCheckInViewCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: kCarOwnerInfoCheckInViewCellIdentifier)
        if cell == nil {
            cell = CarOwnerInfoCheckInViewCell(style: .subtitle, reuseIdentifier: kCarOwnerInfoCheckInViewCellIdentifier)
        }
        
        return cell
    }
    
}
