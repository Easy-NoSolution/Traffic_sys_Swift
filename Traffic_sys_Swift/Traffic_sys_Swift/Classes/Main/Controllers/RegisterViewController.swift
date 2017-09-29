//
//  RegisterViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 21/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - 自定义属性
    lazy var phoneView: RegisterView = RegisterView()
    lazy var passwordView: RegisterView = RegisterView()
    lazy var reinputPasswordView: RegisterView = RegisterView()
    lazy var usernameView: RegisterView = RegisterView()
    lazy var sexView: RegisterView = RegisterView()
    lazy var birthdayView: RegisterView = RegisterView()
    lazy var avatarBtn = UIButton(type: UIButtonType.custom)

    // MARK: - 系统回调函数
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setColor(color: UIColor.clear)
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1)
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
extension RegisterViewController {
    func setupNavigationItem() {
        
        navigationItem.title = "注册"
        
        let rightBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerBtnClicked(_:)))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupView() {
//        1.添加控件
        view.addSubview(phoneView)
        view.addSubview(passwordView)
        view.addSubview(reinputPasswordView)
        view.addSubview(usernameView)
        view.addSubview(sexView)
        view.addSubview(birthdayView)
        view.addSubview(avatarBtn)
        
//        2.设置frame
        phoneView.snp.makeConstraints { (make) in
            make.top.equalTo(98)
            make.left.equalTo(66)
            make.right.equalTo(-66)
            make.height.equalTo(33)
        }
        passwordView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneView.snp.bottom).offset(14)
            make.left.equalTo(66)
            make.right.equalTo(-66)
            make.height.equalTo(33)
        }
        reinputPasswordView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp.bottom).offset(14)
            make.left.equalTo(66)
            make.right.equalTo(-66)
            make.height.equalTo(33)
        }
        usernameView.snp.makeConstraints { (make) in
            make.top.equalTo(reinputPasswordView.snp.bottom).offset(14)
            make.left.equalTo(66)
            make.right.equalTo(-66)
            make.height.equalTo(33)
        }
        sexView.snp.makeConstraints { (make) in
            make.top.equalTo(usernameView.snp.bottom).offset(14)
            make.left.equalTo(66)
            make.right.equalTo(-66)
            make.height.equalTo(33)
        }
        birthdayView.snp.makeConstraints { (make) in
            make.top.equalTo(sexView.snp.bottom).offset(14)
            make.left.equalTo(66)
            make.right.equalTo(-66)
            make.height.equalTo(33)
        }
        avatarBtn.snp.makeConstraints { (make) in
            make.top.equalTo(birthdayView.snp.bottom).offset(14)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(100)
        }
        
//        3.设置属性
        phoneView.titleLabel.text = "手机：+86"
        
        passwordView.titleLabel.text = "设置密码："
        passwordView.valueTextField.isSecureTextEntry = true
        passwordView.valueTextField.placeholder = "设置6-16位密码"
        
        reinputPasswordView.titleLabel.text = "确认密码："
        reinputPasswordView.valueTextField.isSecureTextEntry = true
        reinputPasswordView.valueTextField.placeholder = "设置6-16位密码"
        
        usernameView.titleLabel.text = "用户名："
        
        sexView.titleLabel.text = "性别："
        sexView.valueTextField.isHidden = true
        sexView.sexSelector.isHidden = false
        
        birthdayView.titleLabel.text = "出生日期："
        
        avatarBtn.setBackgroundImage(UIImage(named: "addImage"), for: UIControlState.normal)
        avatarBtn.addTarget(self, action: #selector(avatarBtnClicked(_:)), for: .touchUpInside)
    }
}

// MARK: - 事件监听函数
extension RegisterViewController {
     
    @objc func registerBtnClicked(_ sender: Any) {
        print("click registerBtn")
        
//        1.获取值
        let userId = phoneView.valueTextField.text!
        let username = usernameView.valueTextField.text!
        let userSex = sexView.sexSelector.selectedSegmentIndex as NSInteger
        let userBirthday: Date? = Date(timeIntervalSinceNow: 10)
        let userAvatar: UIImage? = UIImage(named: "addImage")
//        let userAvatar: Data? = Data(count: 1)
        
        let password = passwordView.valueTextField.text!
        
//        2.发送请求
        if userAvatar != nil {
            NetworkTools.shareInstance.registerUserInfo(userId: userId, username: username, userSex: userSex, userBirthday: userBirthday, userAvatar: userAvatar, password: password, finished: { (response, error) in
//                2.1.1.错误校验
                if error != nil {
                    print(error ?? "No value")
                    return
                }
                
//                2.1.2.获取可选类型中的数据
                guard let responseDict = response else {
                    return
                }
                
//                2.1.3.判断数据处理是否成功
                if (responseDict["result"]?.isEqual("failed"))! {
                    print("errorInfo:" + (responseDict["errorInfo"] as! String))
                    
//                2.1.3.1.提示数据处理失败
                    
                    return
                }
                
//                2.1.4.返回上一页
                if (responseDict["result"]?.isEqual("success"))! {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            NetworkTools.shareInstance.registerUserInfo(userId: userId, username: username, userSex: userSex, userBirthday: userBirthday, password: password, finished: { (response, error) in
//                2.2.1.错误校验
                if error != nil {
                    print(error ?? "No value")
                    return
                }
                
//                2.2.2.获取可选类型中的数据
                guard let responseDict = response else {
                    return
                }
                
//                2.2.3.判断数据处理是否成功
                if (responseDict["result"]?.isEqual("failed"))! {
                    print("errorInfo:" + (responseDict["errorInfo"] as! String))
                    
//                2.2.3.1.提示数据处理失败
                    
                    return
                }
                
//                2.2.4.返回上一页
                if (responseDict["result"]?.isEqual("success"))! {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    @objc func avatarBtnClicked(_ sender: Any) {
        
    }
}
