//
//  CarOwnerInfoSearchViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 17/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class CarOwnerInfoSearchViewController: UITableViewController {

    // MARK: - 自定义属性
    lazy var titles: Array<String> = ["身份证号码", "姓名", "性别", "出生日期", "家庭住址", "电话号码"]
    let titleTextField = UITextField()
    var carOwnerVM: CarOwnerViewModel?
    
    // MARK: - 系统回调函数
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        1.创建cell
        let cell = CarOwnerInfoSearchViewCell.searchCellWithTableView(tableView: tableView) as! CarOwnerInfoSearchViewCell
        
//        2.设置属性
        cell.titleLabel.text = titles[indexPath.row] + "："
        
        switch indexPath.row {
        case 0:
            cell.valueLabel.text = carOwnerVM?.carOwner?.carOwnerId
        case 1:
            cell.valueLabel.text = carOwnerVM?.carOwner?.carOwnerName
        case 2:
            cell.valueLabel.text = carOwnerVM?.carOwnerSex
        case 3:
            cell.valueLabel.text = carOwnerVM?.carOwnerBirthday
        case 4:
            cell.valueLabel.text = carOwnerVM?.carOwner?.carOwnerAddress
        case 5:
            cell.valueLabel.text = carOwnerVM?.carOwner?.carOwnerPhoneNumber
        default:
            break;
        }
        
//        3.返回cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let avatarImageView: UIImageView = UIImageView()
        avatarImageView.sd_setImage(with: carOwnerVM?.carOwnerAvatarUrl, placeholderImage: UIImage(named: "avatar_default_big"))
        headerView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.center.equalTo(headerView.snp.center)
            make.width.height.equalTo(100)
        }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
extension CarOwnerInfoSearchViewController {
    
    func setupNavigationItem() {
//        1.设置标题
        titleTextField.placeholder = "    请输入身份证号码    "
        titleTextField.delegate = self
        navigationItem.titleView = titleTextField
        
//        2.设置navigationBar的颜色
        navigationController?.navigationBar.setColor(color: UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0))
        
//        3.设置完成按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBtnClicked(_:)))
    }
    
    func setupView() {
        
    }
}

// MARK: - 事件监听函数
extension CarOwnerInfoSearchViewController {
    
    @objc func searchBtnClicked(_ sender: Any) {
        
//        1.获取参数
        let carOwnerId: String = titleTextField.text ?? ""
        
//        2.验证值
//        2.1.身份证号码
        if !RegexTool.isQualified(text: carOwnerId, pattern: "^(\\d{14}|\\d{17})(\\d|[xX])$") {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "身份证号码为空或者格式不正确")
            return
        }
        
//        3.发送网络请求
        SVProgressHUD.showInfo(withStatus: "正在获取车主信息...")
        NetworkTools.shareInstance.searchCarOwnerInfo(carOwnerId: carOwnerId) {[weak self] (response, error) in
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
            
//            3.4.字典转模型
            let carOwner = CarOwner(dict: responseDict["carOwnerInfo"] as! [String : Any])
            self?.carOwnerVM = CarOwnerViewModel(carOwner: carOwner)
            
//            3.5.更新tableView数据
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITextFieldDelegate
extension CarOwnerInfoSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
}
