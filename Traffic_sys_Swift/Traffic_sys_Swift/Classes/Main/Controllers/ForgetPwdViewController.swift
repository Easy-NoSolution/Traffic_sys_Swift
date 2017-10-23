//
//  ForgetPwdViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 26/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit
import SVProgressHUD

class ForgetPwdViewController: UIViewController {

    // MARK: - 自定义属性
    lazy var phoneView: RegisterView = RegisterView()
    lazy var passwordView: RegisterView = RegisterView()
    lazy var reinputPasswordView: RegisterView = RegisterView()
    lazy var findPwdBtn: UIButton = UIButton(type: .custom)
    
    // MARK: - 系统回调函数
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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

extension ForgetPwdViewController {
    
    func setupNavigationItem() {
        title = "重置密码"
    }
    
    func setupView() {
        
//        1.添加控件
        view.addSubview(phoneView)
        view.addSubview(passwordView)
        view.addSubview(reinputPasswordView)
        view.addSubview(findPwdBtn)
        
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
        findPwdBtn.snp.makeConstraints { (make) in
            make.top.equalTo(reinputPasswordView.snp.bottom).offset(14)
            make.left.equalTo(66)
            make.right.equalTo(-66)
            make.height.equalTo(40)
        }
        
//        3.设置属性
        phoneView.titleLabel.text = "手机：+86"
        phoneView.valueTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: phoneView.valueTextField)
        
        passwordView.titleLabel.text = "新密码："
        passwordView.valueTextField.isSecureTextEntry = true
        passwordView.valueTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: passwordView.valueTextField)
        
        reinputPasswordView.titleLabel.text = "确认密码："
        reinputPasswordView.valueTextField.isSecureTextEntry = true
        reinputPasswordView.valueTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: reinputPasswordView.valueTextField)
        
        findPwdBtn.setTitle("重置密码", for: .normal)
        findPwdBtn.setTitleColor(UIColor.white, for: .normal)
        findPwdBtn.setBackgroundImage(UIImage(named: "ButtonDisnabledColor"), for: .disabled)
        findPwdBtn.setBackgroundImage(UIImage(named: "ButtonEnabledColor"), for: .normal)
        findPwdBtn.isEnabled = false
        findPwdBtn.addTarget(self, action: #selector(findPwdBtnClicked(_:)), for: .touchUpInside)
    }
}

// MARK: - 事件监听函数
extension ForgetPwdViewController {
    
    @objc func textFieldTextDidChange(_ sender: Any) {
        findPwdBtn.isEnabled = (phoneView.valueTextField.text?.count != 0 && passwordView.valueTextField.text?.count != 0 && reinputPasswordView.valueTextField.text?.count != 0)
    }
    
    @objc func findPwdBtnClicked(_ sender: Any) {
//        1.获取数据
        let userId = phoneView.valueTextField.text!
        let password = passwordView.valueTextField.text!
        
//        2.发送网络请求
        SVProgressHUD.showInfo(withStatus: "正在重置密码...")
        NetworkTools.shareInstance.modifyPassword(userId: userId, password: password) {[weak self] (response, error) in
            SVProgressHUD.dismiss()
//            2.1.校验错误
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
                
//                2.3.1.提示数据处理失败
                SVProgressHUD.setMinimumDismissTimeInterval(1)
                SVProgressHUD.showError(withStatus: responseDict["errorInfo"] as! String)
                
                return
            }
            
//            2.4.返回上一页
            if (responseDict["result"]?.isEqual("success"))! {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension ForgetPwdViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}
