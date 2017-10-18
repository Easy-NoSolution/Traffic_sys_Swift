//
//  CheckInViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 16/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class CheckInViewController: UIViewController {

    // MARK: - 自定义属性
    lazy var carInfoCheckInBtn: UIButton = UIButton(type: .custom)
    lazy var carOwnerInfoCheckInBtn: UIButton = UIButton(type: .custom)
    lazy var lawBreakerInfoCheckInBtn: UIButton = UIButton(type: .custom)
    
    // MARK: - 系统回调函数
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - 设置UI界面
extension CheckInViewController {
    
    func setupNavigationItem() {
//        1.设置标题
        navigationItem.title = "登记"
        
//        2.设置navigationBar颜色
        navigationController?.navigationBar.setColor(color: UIColor.clear)
        
//        3.设置返回按钮
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
    }
    
    func setupView() {
//        1.添加子控件
        view.addSubview(carInfoCheckInBtn)
        view.addSubview(carOwnerInfoCheckInBtn)
        view.addSubview(lawBreakerInfoCheckInBtn)
        
//        2.设置frame
        carInfoCheckInBtn.snp.makeConstraints { (make) in
            make.top.equalTo(224)
            make.left.equalTo(62)
            make.right.equalTo(-62)
            make.height.equalTo(40)
        }
        carOwnerInfoCheckInBtn.snp.makeConstraints { (make) in
            make.top.equalTo(314)
            make.left.equalTo(62)
            make.right.equalTo(-62)
            make.height.equalTo(40)
        }
        lawBreakerInfoCheckInBtn.snp.makeConstraints { (make) in
            make.top.equalTo(404)
            make.left.equalTo(62)
            make.right.equalTo(-62)
            make.height.equalTo(40)
        }
        
//        3.设置属性
        carInfoCheckInBtn.setupBtnProperty(viewController: self, action: #selector(carInfoCheckInBtnClicked(_:)), bgColor: UIColor.colorWithHex(hex: kButtonHighlightBackgroundColor, alpha: 1.0), title: "车辆信息登记")
        
        carOwnerInfoCheckInBtn.setupBtnProperty(viewController: self, action: #selector(carOwnerInfoCheckInBtnClicked(_:)), bgColor: UIColor.colorWithHex(hex: kButtonHighlightBackgroundColor, alpha: 1.0), title: "车主信息登记")
        
        lawBreakerInfoCheckInBtn.setupBtnProperty(viewController: self, action: #selector(lawBreakerInfoCheckInBtnClicked(_:)), bgColor: UIColor.colorWithHex(hex: kLawBreakerBtnBackGroundColor, alpha: 1.0), title: "违规信息登记")
    }
}

// MARK: - 事件监听函数
extension CheckInViewController {
    @objc func carInfoCheckInBtnClicked(_ sender: Any) {
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(CarInfoCheckInViewController(), animated: true)
    }
    
    @objc func carOwnerInfoCheckInBtnClicked(_ sender: Any) {
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(CarOwnerInfoCheckInViewController(), animated: true)
    }
    
    @objc func lawBreakerInfoCheckInBtnClicked(_ sender: Any) {
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(LawBreakerInfoCheckInViewController(), animated: true)
    }
}
