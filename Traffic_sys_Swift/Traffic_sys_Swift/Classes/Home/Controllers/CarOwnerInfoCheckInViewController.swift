//
//  CarOwnerInfoCheckInViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 17/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit
import SVProgressHUD

class CarOwnerInfoCheckInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - 自定义属性
    lazy var titles: Array<String> = ["身份证号码", "姓名", "性别", "出生日期", "家庭住址", "电话号码"]
    lazy var tableViewCellsData = Dictionary<NSInteger, AnyObject>()
    lazy var carOwnerAvatarBtn: UIButton = UIButton()
    lazy var carOwnerAvatarIsSelected: Bool = false
    lazy var carOwnerSex: NSInteger = 0
    lazy var birthdayIndex: NSInteger = 3
    lazy var datePicker: UIDatePicker = UIDatePicker()
    let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWindowWidth, height: kWindowHeight), style: .grouped)
    
    // MARK: - 系统回调函数
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carOwnerAvatarBtn.setBackgroundImage(UIImage(named: "addImage"), for: .normal)
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        1.创建cell
        let cell = CarOwnerInfoCheckInViewCell.checkInCellWithTableView(tableView: tableView) as! CarOwnerInfoCheckInViewCell
        
//        2.设置属性
        if indexPath.row == 2 {
            cell.sexSelector.isHidden = false
            cell.homeViewCellDelegate = self
            cell.valueTextField.isHidden = true
        } else {
            cell.sexSelector.isHidden = true
            cell.valueTextField.isHidden = false
        }
        cell.titleLabel.text = titles[indexPath.row] + "："
        cell.valueTextField.placeholder = "请输入" + titles[indexPath.row]
        cell.valueTextField.delegate = self
        
        switch indexPath.row {
        case 2:
            cell.sexSelector.isHidden = false
            cell.homeViewCellDelegate = self
            cell.valueTextField.isHidden = true
            
        case 3:
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
        
//        3.返回cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        
        carOwnerAvatarBtn.addTarget(self, action: #selector(carOwnerAvatarBtnClicked(_:)), for: .touchUpInside)
        footer.addSubview(carOwnerAvatarBtn)
        carOwnerAvatarBtn.snp.makeConstraints { (make) in
            make.top.equalTo(44)
            make.centerX.equalTo(footer.snp.centerX)
            make.width.height.equalTo(100)
        }
        
        return footer
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
extension CarOwnerInfoCheckInViewController {
    
    func setupNavigationItem() {
//        1.设置标题
        navigationItem.title = "车主信息登记"
        
//        2.设置navigationBar的颜色
        navigationController?.navigationBar.setColor(color: UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0))
        
//        3.设置完成按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(doneBtnClicked(_:)))
    }
    
    func setupView() {
        
//        1.设置tableView
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
    }
}

// MARK: - 事件监听函数
extension CarOwnerInfoCheckInViewController {
    
    @objc func doneBtnClicked(_ sender: Any) {
//        1.获取参数
        let carOwnerId: String = tableViewCellsData[0] as? String ?? ""
        let carOwnerName: String = tableViewCellsData[1] as? String ?? ""
        let carOwnerSex: NSInteger = self.carOwnerSex
        let carOwnerBirthday: Date? = datePicker.date
        let carOwnerAddress: String = tableViewCellsData[4] as? String ?? ""
        let carOwnerPhoneNumber: String = tableViewCellsData[5] as? String ?? ""
        let carOwnerAvatar: UIImage? = carOwnerAvatarBtn.backgroundImage(for: .normal)
        let fmt: DateFormatter = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        fmt.locale = Locale(identifier: "zh_Hans_CN")
        fmt.timeZone = TimeZone(identifier: "Asia/Shanghai")
        
//        2.验证值
//        2.1.身份证号码
        if !RegexTool.isQualified(text: carOwnerId, pattern: "^(\\d{14}|\\d{17})(\\d|[xX])$") {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "身份证号码为空或者格式不正确")
            return
        }
//        2.2.用户名
        if !RegexTool.isQualified(text: carOwnerName, pattern: "^[\u{4E00}-\u{9FA5}]{2,8}$") && !RegexTool.isQualified(text: carOwnerName, pattern: "^[a-zA-Z\\s]{2,8}$") {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "性名为空或者格式不正确")
            return
        }
//        2.3.出生日期
        if fmt.string(from: carOwnerBirthday!).isEmpty {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "出生日期为空或者格式不正确")
            return
        }
//        2.4.家庭住址
        if carOwnerAddress.characters.count < 0 {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "家庭住址为空或者格式不正确")
            return
        }
//        2.5.电话号码
        if !RegexTool.isQualified(text: carOwnerPhoneNumber, pattern: "^1[3578]\\d{9}$") {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "电话号码为空或者格式不正确")
            return
        }
        
//        3.发送网络请求
        SVProgressHUD.showInfo(withStatus: "正在注册用户数据...")
        NetworkTools.shareInstance.carOwnerInfoCheckIn(carOwnerId: carOwnerId, carOwnerName: carOwnerName, carOwnerSex: carOwnerSex, carOwnerBirthday: fmt.string(from: carOwnerBirthday!), carOwnerAddress: carOwnerAddress, carOwnerPhoneNumber: carOwnerPhoneNumber, carOwnerAvatar: carOwnerAvatar) {[weak self] (response, error) in
            SVProgressHUD.dismiss()
//            3.1.校验nil值
            if error != nil {
                print(error ?? "error")
                return
            }
            
//            3.2.获取可选类型中的数据
            guard let responseDict = response else {
                return
            }
            
//            3.3.判断数据处理是否成功
            if (responseDict["result"]?.isEqual("failed"))! {
                
//                3.3.1.提示数据处理失败
                SVProgressHUD.setMinimumDismissTimeInterval(1)
                SVProgressHUD.showError(withStatus: responseDict["errorInfo"] as! String)
                
                return
            }
            
//            3.4.返回上一级控制器
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func doneBtnItemClicked(_ sender: UIBarButtonItem) {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy年MM月dd日"
        fmt.locale = Locale(identifier: "zh_Hans_CN")
        birthdayIndex = sender.tag
        let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! CarOwnerInfoCheckInViewCell
        cell.valueTextField.text = fmt.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc func carOwnerAvatarBtnClicked(_ sender: Any) {
        
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

extension CarOwnerInfoCheckInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        1.获取当前正在编辑的cell
        let cell: CarOwnerInfoCheckInViewCell = textField.superview?.superview as! CarOwnerInfoCheckInViewCell
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

// MARK: - HomeViewCellDelegate
extension CarOwnerInfoCheckInViewController: HomeViewCellDelegate {
    
    func sexValueChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        carOwnerSex = sender.selectedSegmentIndex
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationController
extension CarOwnerInfoCheckInViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
//        1.获取图片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
//        2.展示图片
        carOwnerAvatarBtn.setBackgroundImage(image, for: .normal)
        carOwnerAvatarIsSelected = true
        
//        3.退出图片选择控制器
        picker.dismiss(animated: true, completion: nil)
    }
}
