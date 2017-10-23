//
//  LawBreakerInfoSearchByCarIdViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 17/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit
import SVProgressHUD

class LawBreakerInfoSearchByCarIdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - 自定义属性
    lazy var titles: Array<String> = ["车牌号", "身份证号码", "车主姓名", "性别", "电话号码"]
    let titleTextField = UITextField()
    lazy var tableViewDatas: Array<LawbreakerInfoViewModel> = Array<LawbreakerInfoViewModel>()
    let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWindowWidth, height: kWindowHeight), style: .grouped)
    
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
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableViewDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        1.创建cell
        let cell = LawBreakerInfoSearchByCarIdViewCell.searchCellWithTableView(tableView: tableView) as! LawBreakerInfoSearchByCarIdViewCell
        
//        2.设置属性
        cell.titleLabel.text = titles[indexPath.row] + "："
        
        if tableViewDatas.count > indexPath.section {
            let lawbreakerVM = tableViewDatas[indexPath.section]
            
            switch indexPath.row {
            case 0:
                cell.valueLabel.text = lawbreakerVM.lawbreakerInfo?.carId
            case 1:
                cell.valueLabel.text = lawbreakerVM.lawbreakerInfo?.carOwnerId
            case 2:
                cell.valueLabel.text = lawbreakerVM.lawbreakerInfo?.carOwnerName
            case 3:
                cell.valueLabel.text = lawbreakerVM.carOwnerSex
            case 4:
                cell.valueLabel.text = lawbreakerVM.lawbreakerInfo?.carOwnerPhoneNumber
            default:
                break
            }
        }
        
//        3.返回cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        
        let titleLabel: UILabel = UILabel()
        titleLabel.textAlignment = .center
        if tableViewDatas.count > section {
            titleLabel.text = "违规信息：\(tableViewDatas[section].lawbreakerInfo?.lawbreakerInfoId ?? 1)"
        }
        header.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.centerX.equalTo(header.snp.centerX)
            make.width.equalTo(100)
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 251
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footer = UIView()
        footer.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        
        let textView: UITextView = UITextView()
        textView.isEditable = false
        if tableViewDatas.count > section {
            textView.text = tableViewDatas[section].lawbreakerInfo?.lawbreakerInfo ?? ""
        }
        footer.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(1)
            make.centerX.equalTo(footer.snp.centerX)
            make.width.equalTo(320)
            make.height.equalTo(250)
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
extension LawBreakerInfoSearchByCarIdViewController {
    
    func setupNavigationItem() {
//        1.设置标题
        titleTextField.placeholder = "请输入车牌号"
        titleTextField.delegate = self
        navigationItem.titleView = titleTextField
        
//        2.设置navigationBar的颜色
        navigationController?.navigationBar.setColor(color: UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0))
        
//        3.设置完成按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBtnClicked(_:)))
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
extension LawBreakerInfoSearchByCarIdViewController {
    
    @objc func searchBtnClicked(_ sender: Any) {
        
//        1.获取参数
        let carId: String = titleTextField.text ?? ""
        
//        2.验证值
//        2.1.车牌号
        if !RegexTool.isQualified(text: carId, pattern: "^[\u{4e00}-\u{9fa5}]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u{4e00}-\u{9fa5}]$") {
            SVProgressHUD.setMinimumDismissTimeInterval(1)
            SVProgressHUD.showError(withStatus: "车牌号为空或者格式不正确")
            return
        }
        
//        3.发送网络请求
        SVProgressHUD.showInfo(withStatus: "正在获取违规信息...")
        NetworkTools.shareInstance.searchLawbreakerInfoByCarId(carId: carId) {[weak self] (response, error) in
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
            self?.tableViewDatas.removeAll()
            for dic in responseDict["lawbreakerInfos"] as! Array<[String : Any]> {
                
                let lawbreakerInfo = LawbreakerInfo(dict: dic as [String : Any])
                let lawbreakerInfoVM = LawbreakerInfoViewModel(lawbreakerInfo: lawbreakerInfo)
                self?.tableViewDatas.append(lawbreakerInfoVM)
            }
            
//            3.5.更新tableView的数据
            self?.tableView.reloadData()
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension LawBreakerInfoSearchByCarIdViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
}
