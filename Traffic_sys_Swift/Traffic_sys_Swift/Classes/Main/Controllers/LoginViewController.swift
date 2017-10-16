//
//  LoginViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 26/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - 自定义属性
    lazy var phoneView: RegisterView = RegisterView()
    lazy var passwordView: RegisterView = RegisterView()
    lazy var loginBtn: UIButton = UIButton(type: .custom)
    lazy var forgetPwdBtn: UIButton = UIButton(type: .custom)

    // MARK: - 系统回调函数
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setColor(color: UIColor.clear)
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1)
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
extension LoginViewController {
    
    func setupNavigationItem() {
        title = "登录"
        
        let backItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    func setupView() {
//        1.添加控件
        view.addSubview(phoneView)
        view.addSubview(passwordView)
        view.addSubview(loginBtn)
        view.addSubview(forgetPwdBtn)
        
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
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp.bottom).offset(31)
            make.left.equalTo(66)
            make.right.equalTo(-66)
            make.height.equalTo(40)
        }
        forgetPwdBtn.snp.makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp.bottom).offset(14)
            make.left.equalTo(123)
            make.right.equalTo(-123)
            make.height.equalTo(17)
        }
        
//        3.设置属性
        phoneView.titleLabel.text = "手机：+86"
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: phoneView.valueTextField)
        
        passwordView.titleLabel.text = "密码："
        passwordView.valueTextField.isSecureTextEntry = true
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: passwordView.valueTextField)
        
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.setBackgroundImage(UIImage(named: "ButtonDisnabledColor"), for: .disabled)
        loginBtn.setBackgroundImage(UIImage(named: "ButtonEnabledColor"), for: .normal)
        loginBtn.isEnabled = false
        loginBtn.addTarget(self, action: #selector(loginBtnClicked(_:)), for: .touchUpInside)
        
        forgetPwdBtn.setTitle("忘记密码?", for: .normal)
        forgetPwdBtn.setTitleColor(UIColor.colorWithHex(hex: kForgetPwdTextColor, alpha: 1), for: .normal)
        forgetPwdBtn.addTarget(self, action: #selector(forgetPwdBtnClicked(_:)), for: .touchUpInside)
    }
}

// MARK: - 事件监听函数
extension LoginViewController {
    
    @objc func textFieldTextDidChange(_ sender: Any) {
        loginBtn.isEnabled = (phoneView.valueTextField.text?.count != 0 && passwordView.valueTextField.text?.count != 0)
    }
    
    @objc func loginBtnClicked(_ sender: Any) {
        
//        1.获取参数
        let userId = phoneView.valueTextField.text!
        let password = passwordView.valueTextField.text!
        
//        2.发送请求
        NetworkTools.shareInstance.login(userId: userId, password: password) { (response, error) in
//            2.1.错误校验
            if error != nil {
                print(error ?? "error")
                return
            }
            
//            2.2.获取可选类型中的数据
            guard let responseDict = response else {
                return
            }
            
//            2.3.判断数据处理是否成功
            if (responseDict["result"]?.isEqual("failed"))! {
                print("errorInfo:" + (responseDict["errorInfo"] as! String))
                
//                2.3.1.提示数据处理失败
                
                return
            }
            
//            2.4.遍历微博对应的字典
            let userInfo = UserInfo(dict: responseDict["userInfo"] as! [String : Any])
            print(userInfo)
            
//            2.5.将数据保存到沙盒
            NSKeyedArchiver.archiveRootObject(userInfo, toFile: UserInfoViewModel.userInfoPath)
            
//            2.6.将userInfo保存到单例中
            UserInfoViewModel.shareInstance.userInfo = userInfo
            
//            2.7.跳转到首页
            if (responseDict["result"]?.isEqual("success"))! {
                let tabBarVc = TabBarViewController()
                UIApplication.shared.keyWindow?.rootViewController = tabBarVc
            }
        }
    }
    
    @objc func forgetPwdBtnClicked(_ sender: Any) {
        let forgetPwdVc = ForgetPwdViewController()
        navigationController?.pushViewController(forgetPwdVc, animated: true)
    }
}
