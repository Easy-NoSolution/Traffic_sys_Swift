//
//  LawBreakerInfoSearchByCarIdViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 17/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class LawBreakerInfoSearchByCarIdViewController: UITableViewController {

    // MARK: - 自定义属性
    lazy var titles: Array<String> = ["车牌号", "身份证号码", "车主姓名", "性别", "电话号码"]
    lazy var titleLabel: UILabel = UILabel()
    lazy var textView: UITextView = UITextView()
    
    // MARK: - 系统回调函数
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.textAlignment = .center
        titleLabel.text = "违规信息：\(1)"
        
        textView.text = "《人民的名义》是由李路执导、周梅森编剧的检察反腐电视剧，由陆毅、张丰毅、吴刚、许亚军、张志坚、柯蓝、胡静、张凯丽、赵子琪、白志迪、李建义、王丽云、高亚麟、丁海峰、冯雷、李光复、陶慧敏、张晞临等联袂主演，黄俊鹏、侯勇、许文广、徐光宇、沈晓海、侯天来、周浩东、黄品沅、刘伟、赵龙豪、李学政等特别出演。\n该剧以检察官侯亮平的调查行动为叙事主线，讲述了当代检察官维护公平正义和法制统一、查办贪腐案件的故事，于2017年3月28日在湖南卫视“金鹰独播剧场”播出[1]。\n2017年4月27日，该剧在GMIC X 2017非凡盛典上获得”互联网时代最具影响力影视作品“奖[2]  ；6月16日，吴刚和张志坚凭该剧荣获第23届上海电视节白玉兰最佳男配角奖。[3] "
        textView.isEditable = false
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
        let cell = LawBreakerInfoSearchByCarIdViewCell.searchCellWithTableView(tableView: tableView) as! LawBreakerInfoSearchByCarIdViewCell
        
//        2.设置属性
        cell.titleLabel.text = titles[indexPath.row] + "："
        cell.valueLabel.text = "请输入" + titles[indexPath.row]
        
//        3.返回cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        
        header.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.centerX.equalTo(header.snp.centerX)
            make.width.equalTo(100)
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 251
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footer = UIView()
        footer.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        
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
        let titleTextField = UITextField()
        titleTextField.placeholder = "请输入车牌号"
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
extension LawBreakerInfoSearchByCarIdViewController {
    
    @objc func searchBtnClicked(_ sender: Any) {
        print(1)
    }
    
    @objc func userAvatarBtnClicked(_ sender: Any) {
        print(2)
    }
}
