//
//  ModifyProfileInfoViewCell.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 06/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class ModifyProfileInfoViewCell: UITableViewCell {

    // MARK: - 自定义属性
    var titleLabel: UILabel = UILabel()
    var valueTextField: UITextField = UITextField()
    
    // MARK: - 系统回调函数
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        selectionStyle = .none
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
extension ModifyProfileInfoViewCell {
    static func cellWithTableView(tableView: UITableView) -> UITableViewCell? {
        let kModifyProfileInfoIdentifier = "ModifyProfileInfoIdentifier"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: kModifyProfileInfoIdentifier)
        
        if cell == nil {
            cell = ModifyProfileInfoViewCell(style: .subtitle, reuseIdentifier: kModifyProfileInfoIdentifier)
        }
        
        return cell
    }
}

// MARK: - 设置UI界面
extension ModifyProfileInfoViewCell {
    
    func setupView() {
    
//        1.添加控件
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueTextField)
        
//        2.设置frame
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(13)
            make.left.equalTo(15)
            make.width.lessThanOrEqualTo(85)
            make.height.equalTo(18)
        }
        valueTextField.snp.makeConstraints { (make) in
            make.top.equalTo(13)
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.right.equalTo(-15)
            make.height.equalTo(20)
        }
        
//        3.设置属性
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        valueTextField.textAlignment = .right
        valueTextField.font = UIFont.systemFont(ofSize: 15)
    }
}
