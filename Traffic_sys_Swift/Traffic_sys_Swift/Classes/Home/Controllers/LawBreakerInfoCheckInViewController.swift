//
//  LawBreakerInfoCheckInViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 17/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit
import SVProgressHUD

class LawBreakerInfoCheckInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - 自定义属性
    lazy var titles: Array<String> = ["车牌号", "身份证号码", "姓名", "电话号码"]
    lazy var tableViewCellsData = Dictionary<NSInteger, AnyObject>()
    lazy var textView: TextView = TextView()
    let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWindowWidth, height: kWindowHeight), style: .grouped)
    
    // MARK: - 系统回调函数
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        1.设置textView
        textView.placeholder.text = "请输入违规原因："
        textView.placeholderColor = UIColor.colorWithHex(hex: kPlaceHolderColor, alpha: 1.0)
        textView.placeholderFont = UIFont.systemFont(ofSize: 15.0)
        textView.font = UIFont.systemFont(ofSize: 15.0)
        
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
        let cell = LawBreakerInfoCheckInViewCell.checkInCellWithTableView(tableView: tableView) as! LawBreakerInfoCheckInViewCell
        
//        2.设置属性
        cell.titleLabel.text = titles[indexPath.row] + "："
        cell.valueTextField.placeholder = "请输入" + titles[indexPath.row]
        cell.valueTextField.delegate = self
        
//        3.返回cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footer = UIView()
        footer.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        
        footer.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(21)
            make.centerX.equalTo(footer.snp.centerX)
            make.width.equalTo(320)
            make.height.equalTo(420)
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
extension LawBreakerInfoCheckInViewController {
    
    func setupNavigationItem() {
//        1.设置标题
        navigationItem.title = "违规信息登记"
        
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
extension LawBreakerInfoCheckInViewController {
    
    @objc func doneBtnClicked(_ sender: Any) {
//        1.获取参数
        let carId: String = tableViewCellsData[0] as? String ?? ""
        let carOwnerId: String = tableViewCellsData[1] as? String ?? ""
        let lawbreakerInfo: String = textView.text
        
//        2.验证值
//        2.1.车牌号
        if !RegexTool.isQualified(text: carId, pattern: "^[\u{4e00}-\u{9fa5}]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u{4e00}-\u{9fa5}]$") {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "车牌号为空或者格式不正确")
            return
        }
//        2.2.身份证号码
        if !RegexTool.isQualified(text: carOwnerId, pattern: "^(\\d{14}|\\d{17})(\\d|[xX])$") {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "身份证号码为空或者格式不正确")
            return
        }
//        2.3.违规原因
        if textView.text.count == 0 {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "违规原因为空或者格式不正确")
            return
        }
        
//        3.发送网络请求
        SVProgressHUD.showInfo(withStatus: "正在注册违规信息...")
        NetworkTools.shareInstance.lawbreakerInfoCheckIn(carId: carId, carOwnerId: carOwnerId, lawbreakerInfo: lawbreakerInfo) {[weak self] (response, error) in
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
}

extension LawBreakerInfoCheckInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //        1.获取当前正在编辑的cell
        let cell: LawBreakerInfoCheckInViewCell = textField.superview?.superview as! LawBreakerInfoCheckInViewCell
        
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
