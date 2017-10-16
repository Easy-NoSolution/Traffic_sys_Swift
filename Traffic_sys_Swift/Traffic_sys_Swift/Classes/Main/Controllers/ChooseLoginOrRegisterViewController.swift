//
//  ChooseLoginOrRegisterViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 21/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit
import SnapKit

class ChooseLoginOrRegisterViewController: UIViewController {
    
    // MARK: - 自定义属性
    lazy var phoneLoginBtn = UIButton(type: UIButtonType.custom)
    lazy var registerBtn = UIButton(type: UIButtonType.custom)

    // MARK: - 系统回调函数
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1)
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        设置UI
        setupUIView();
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
extension ChooseLoginOrRegisterViewController {
    func setupUIView() {
//        1.将控件添加到View中
        view.addSubview(phoneLoginBtn)
        view.addSubview(registerBtn)
        
//        2.设置frame
        phoneLoginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(278)
            make.left.equalTo(62)
            make.right.equalTo(-62)
            make.height.equalTo(40)
        }
        
        registerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(344)
            make.left.equalTo(62)
            make.right.equalTo(-62)
            make.height.equalTo(40)
        }
        
//        3.设置属性
        phoneLoginBtn.setTitle("手机号登录", for: .normal)
        phoneLoginBtn.setTitleColor(UIColor.white, for: .normal)
        phoneLoginBtn.backgroundColor = UIColor.colorWithHex(hex: kButtonHighlightBackgroundColor, alpha: 1)
        phoneLoginBtn.layer.cornerRadius = 8
        phoneLoginBtn.layer.masksToBounds = true
        phoneLoginBtn.addTarget(self, action: #selector(phoneLoginBtnClicked(_:)), for: .touchUpInside)
        
        registerBtn.setTitle("注册", for: .normal)
        registerBtn.setTitleColor(UIColor.colorWithHex(hex: kButtonHighlightBackgroundColor, alpha: 1), for: .normal)
        registerBtn.backgroundColor = UIColor.white
        registerBtn.layer.cornerRadius = 8
        registerBtn.layer.masksToBounds = true
        registerBtn.addTarget(self, action: #selector(registerBtnClicked(_:)), for: .touchUpInside)
    }
    
    func setupNavigationItem() {
        let backItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
}

// MARK: - 事件监听函数
extension ChooseLoginOrRegisterViewController {
    
    @objc func phoneLoginBtnClicked(_ sender: Any) {
        let loginVc = LoginViewController()
        navigationController?.pushViewController(loginVc, animated: true)
    }
    
    @objc func registerBtnClicked(_ sender: Any) {
        let registerVc = RegisterViewController()
        navigationController?.pushViewController(registerVc, animated: true)
    }
}

