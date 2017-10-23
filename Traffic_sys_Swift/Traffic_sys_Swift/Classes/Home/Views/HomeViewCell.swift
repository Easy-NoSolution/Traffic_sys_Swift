//
//  HomeViewCell.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 17/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

// MARK: - 面向协议开发
protocol HomeViewCellDelegate: NSObjectProtocol {
    func sexValueChanged(_ sender: UISegmentedControl)
}

class HomeViewCell: UITableViewCell {
    
    // MARK: - 自定义属性
    var titleLabel: UILabel = UILabel()
    var valueLabel: UILabel = UILabel()
    var valueTextField: UITextField = UITextField()
    lazy var sexSelector = UISegmentedControl()
    var homeViewCellDelegate: HomeViewCellDelegate?
    
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
extension HomeViewCell {
    
    static func cellWithTableView(tableView: UITableView) -> UITableViewCell? {
        let kHomeViewCellIdentifier = "HomeViewCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: kHomeViewCellIdentifier)
        if cell == nil {
            cell = HomeViewCell(style: .subtitle, reuseIdentifier: kHomeViewCellIdentifier)
        }
        
        return cell
    }
}

// MARK: - 设置UI界面
extension HomeViewCell {
    
    func setupView()  {
//        1.添加控件
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(valueTextField)
        contentView.addSubview(sexSelector)
        
//        2.设置frame
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(13)
            make.left.equalTo(15)
            make.width.lessThanOrEqualTo(125)
            make.height.equalTo(18)
        }
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(13)
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.right.equalTo(-15)
            make.height.equalTo(20)
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
        
        valueLabel.textAlignment = .right
        valueLabel.textColor = UIColor.colorWithHex(hex: kTextNormalColor, alpha: 1.0)
        valueLabel.font = UIFont.systemFont(ofSize: 15)
        
        valueTextField.textAlignment = .right
        valueTextField.font = UIFont.systemFont(ofSize: 15)
        
        sexSelector.insertSegment(withTitle: "男", at: 0, animated: false)
        sexSelector.insertSegment(withTitle: "女", at: 1, animated: false)
        sexSelector.selectedSegmentIndex = 0
        sexSelector.addTarget(self, action: #selector(sexSelectorValueChanged(_:)), for: .valueChanged)
    }
}

// MARK: - 事件监听函数
extension HomeViewCell {
    
    @objc func sexSelectorValueChanged(_ sender: UISegmentedControl) {
        
        //        0.nil校验
        guard let homeViewCellDelegate = homeViewCellDelegate else {
            return
        }
        
        //        2.向代理发送事件
        homeViewCellDelegate.sexValueChanged(sender)
    }
}
