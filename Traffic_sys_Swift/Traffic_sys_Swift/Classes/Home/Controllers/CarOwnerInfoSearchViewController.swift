//
//  CarOwnerInfoSearchViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 17/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class CarOwnerInfoSearchViewController: UITableViewController {

    // MARK: - 自定义属性
    lazy var titles: Array<String> = ["身份证号码", "姓名", "性别", "出生日期", "家庭住址", "电话号码"]
    var avatarImageView: UIImageView = UIImageView()
    
    // MARK: - 系统回调函数
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.backgroundColor = UIColor.green
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
        cell.valueLabel.text = "请输入" + titles[indexPath.row]
        
//        3.返回cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
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
        let titleTextField = UITextField()
        titleTextField.placeholder = "    请输入身份证号码    "
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
        print(1)
    }
    
    @objc func userAvatarBtnClicked(_ sender: Any) {
        print(2)
    }
}
