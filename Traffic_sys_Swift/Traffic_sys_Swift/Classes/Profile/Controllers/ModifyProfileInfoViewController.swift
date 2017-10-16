//
//  ModifyProfileInfoViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 06/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit
import SVProgressHUD

class ModifyProfileInfoViewController: UITableViewController {

    // MARK: - 自定义属性
    let userInfo: UserInfo? = UserInfoViewModel.shareInstance.userInfo
    let titleData = ["用户名：", "性别：", "出生日期："]
    lazy var tableViewCellsData = Dictionary<NSInteger, AnyObject>()
    lazy var userAvatarBtn: UIButton = UIButton(type: .custom)
    lazy var userSex: NSInteger = 0
    lazy var birthdayIndex: NSInteger = 2
    lazy var userAvatarIsSelected: Bool = false
    lazy var datePicker: UIDatePicker = UIDatePicker()
    
    // MARK: - 系统回调函数
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(tableViewCellsData)
        
        userAvatarBtn.setBackgroundImage(UIImage(named: "changeImage"), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        userAvatarBtn.addTarget(self, action: #selector(userAvatarBtnClicked(_:)), for: .touchUpInside)
        headerView.addSubview(userAvatarBtn)
        userAvatarBtn.snp.makeConstraints { (make) in
            make.center.equalTo(headerView.snp.center)
            make.width.height.equalTo(100)
        }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ModifyProfileInfoViewCell.cellWithTableView(tableView: tableView) as! ModifyProfileInfoViewCell
        
        cell.titleLabel.text = titleData[indexPath.row]
        
        if indexPath.row == 1 {
            cell.sexSelector.isHidden = false
            cell.modifyProfileInfoViewCellDelegate = self
            cell.valueTextField.isHidden = true
        } else {
            cell.sexSelector.isHidden = true
            cell.valueTextField.isHidden = false
        }
        
        switch indexPath.row {
        case 1:
            cell.sexSelector.isHidden = false
            cell.modifyProfileInfoViewCellDelegate = self
            cell.valueTextField.isHidden = true
            
        case 2:
            datePicker.datePickerMode = .date
            datePicker.locale = Locale(identifier: "zh_Hans_CN")
            cell.valueTextField.inputView = datePicker
            let accessoryView = UIToolbar(frame: CGRect(x: 0, y: 0, width: kWindowWidth, height: 44))
            accessoryView.backgroundColor = UIColor.gray
            let flexibleBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneBtnItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(doneBtnItemClicked(_:)))
            doneBtnItem.tag = indexPath.row
            doneBtnItem.tintColor = UIColor.blue
            accessoryView.items = [flexibleBtn, doneBtnItem]
            cell.valueTextField.inputAccessoryView = accessoryView
            cell.sexSelector.isHidden = true
            cell.valueTextField.isHidden = false
        default:
            cell.sexSelector.isHidden = true
            cell.valueTextField.isHidden = false
        }
        
        //        3.设置代理
        cell.valueTextField.delegate = self
        
        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
extension ModifyProfileInfoViewController {
    
    func setupNavigationItem() {
//        1.设置标题
        navigationItem.title = "修改个人信息"
        
//        2.设置背景颜色
        navigationController?.navigationBar.setColor(color: UIColor.clear)
        
//        3.设置完成按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(doneBtnClicked(_:)))
    }
}

// MARK: - 事件监听函数
extension ModifyProfileInfoViewController {
    
    @objc func doneBtnClicked(_ sender: Any) {
        print(tableViewCellsData)
//        1.获取参数
        let userAvatar: UIImage? = userAvatarBtn.backgroundImage(for: .normal)
        guard let userId = userInfo?.userId else {
            return
        }
        guard let username: String = tableViewCellsData[0] as? String else {
            return
        }
        let userSex: NSInteger = self.userSex
        let userBirthday: Date? = datePicker.date
        let fmt = DateFormatter()
        fmt.timeZone = TimeZone(identifier: "Asia/Shanghai")
        fmt.locale = Locale(identifier: "zh_Hans_CN")
        fmt.dateFormat = "yyyy-MM-dd"
        
//        2.验证值
//        2.1.用户名
        if !RegexTool.isQualified(text: username, pattern: "^[\u{4E00}-\u{9FA5}]{2,8}$") && !RegexTool.isQualified(text: username, pattern: "^[a-zA-Z\\s]{2,8}$") {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "用户名为空或者格式不正确")
            return
        }
        let cell = tableView.cellForRow(at: IndexPath(row: birthdayIndex, section: 0)) as! ModifyProfileInfoViewCell
        //        2.2.出生日期
        if (cell.valueTextField.text?.isEmpty)! {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "出生日期为空或者格式不正确")
            return
        }
//        2.3.头像
        if !userAvatarIsSelected {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "用户头像不能为空")
            return
        }
        
//        3.发送网络请求
        NetworkTools.shareInstance.modifyUserInfo(userId: userId, username: username, userSex: userSex, userBirthday: fmt.string(from: userBirthday!), userAvatar: userAvatar) { (response, error) in
            
//            3.1.校验nil值
            if error != nil {
                print(error ?? "error")
                return
            }
            
//            3.2.获取可选类型中的数据
            guard let responseDict = response else {
                return
            }
            
//            3.3.判断数据更新是否成功
            if (responseDict["result"]?.isEqual("failed"))! {
                print("errorInfo:" + (responseDict["errorInfo"] as! String))
                
                //                3.3.1.提示数据处理失败
                
                return
            }
            
//            3.4.遍历微博对应的字典
            let userInfo = UserInfo(dict: responseDict["userInfo"] as! [String : Any])
            print("返回结果")
            print(userInfo)
            
//            3.5.将数据保存到沙盒
            NSKeyedArchiver.archiveRootObject(userInfo, toFile: UserInfoViewModel.userInfoPath)
            
//            3.6.将userInfo保存到单例中
            UserInfoViewModel.shareInstance.userInfo = userInfo
            
//            3.7.发送更新数据的通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ModifyUserInfoNote), object: nil)
            
//            3.8.返回上一级控制器
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func doneBtnItemClicked(_ sender: UIBarButtonItem) {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy年MM月dd日"
        fmt.locale = Locale(identifier: "zh_Hans_CN")
        birthdayIndex = sender.tag
        let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! ModifyProfileInfoViewCell
        cell.valueTextField.text = fmt.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc func userAvatarBtnClicked(_ sender: Any) {
        
//        1.判断照片源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        
//        2.创建照片选择控制器
        let ipc = UIImagePickerController()
        
//        3.设置控制器的源
        ipc.sourceType = .photoLibrary
        
//        4.设置代理
        ipc.delegate = self
        
//        5.弹出照片选择控制器
        present(ipc, animated: true, completion: nil)
    }
}


extension ModifyProfileInfoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

//        1.获取当前正在编辑的cell
        let cell: ModifyProfileInfoViewCell = textField.superview?.superview as! ModifyProfileInfoViewCell

//        2.获取当前cell的indexPath及值
        guard let indexPath = tableView.indexPath(for: cell) else {
            return true
        }
        guard let text = textField.text as NSString? else {
            return true
        }
        
//        3.将值赋值到字典中
        tableViewCellsData[indexPath.row] = text.replacingCharacters(in: range, with: string) as AnyObject

        return true
    }
}

// MARK: - ModifyProfileInfoViewCellDelegate
extension ModifyProfileInfoViewController: ModifyProfileInfoViewCellDelegate {
    
    func sexValueChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        userSex = sender.selectedSegmentIndex
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationController
extension ModifyProfileInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
//        1.获取图片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
//        2.展示图片
        userAvatarBtn.setBackgroundImage(image, for: .normal)
        userAvatarIsSelected = true
        
//        3.退出图片选择控制器
        picker.dismiss(animated: true, completion: nil)
    }
}
