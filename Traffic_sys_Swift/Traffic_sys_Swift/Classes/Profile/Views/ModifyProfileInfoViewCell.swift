//
//  ModifyProfileInfoViewCell.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 06/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

// MARK: - 面向协议开发
protocol ModifyProfileInfoViewCellDelegate: NSObjectProtocol {
    func sexValueChanged(_ sender: UISegmentedControl)
}

class ModifyProfileInfoViewCell: UITableViewCell {

    // MARK: - 自定义属性
    lazy var titleLabel: UILabel = UILabel()
    lazy var valueTextField: UITextField = UITextField()
    lazy var sexSelector = UISegmentedControl()
    var modifyProfileInfoViewCellDelegate: ModifyProfileInfoViewCellDelegate?
    
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
        contentView.addSubview(sexSelector)
        
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
        sexSelector.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.height.equalTo(17)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(70)
        }
        
//        3.设置属性
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        valueTextField.textAlignment = .right
        valueTextField.font = UIFont.systemFont(ofSize: 15)
        
        sexSelector.insertSegment(withTitle: "男", at: 0, animated: false)
        sexSelector.insertSegment(withTitle: "女", at: 1, animated: false)
        sexSelector.selectedSegmentIndex = 0
        sexSelector.isHidden = true
        sexSelector.addTarget(self, action: #selector(sexSelectorValueChanged(_:)), for: .valueChanged)
    }
}

// MARK: - 事件监听函数
extension ModifyProfileInfoViewCell {
    
    @objc func sexSelectorValueChanged(_ sender: UISegmentedControl) {
        
//        0.nil校验
        guard let modifyProfileInfoViewCellDelegate = modifyProfileInfoViewCellDelegate else {
            return
        }
        
//        2.向代理发送事件
        modifyProfileInfoViewCellDelegate.sexValueChanged(sender)
    }
}
