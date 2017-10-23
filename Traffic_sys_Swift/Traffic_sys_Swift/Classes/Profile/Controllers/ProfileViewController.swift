//
//  ProfileViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 28/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh
import SVProgressHUD

class ProfileViewController: UITableViewController {

    // MARK: - 自定义属性
    let titles: Array<String> = ["电话号码", "用户名", "性别", "出生日期"]
    var avatarImageView: UIImageView = UIImageView()
    var userInfo: UserInfo? = UserInfoViewModel.shareInstance.userInfo
    
    // MARK: - 系统回调函数
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        1.设置主界面
        setupView()
        
        print(NSHomeDirectory())
//        2.监听通知
        setupNotifications()
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
        return 4
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        1.创建cell
        let cell = ProfileViewCell.cellWithTableView(tableView: tableView) as! ProfileViewCell

//        2.添加数据
        cell.titleLabel.text = titles[indexPath.row] + "："
        switch indexPath.row {
        case 0:
            cell.valueLabel.text = userInfo?.userId
        case 1:
            cell.valueLabel.text = userInfo?.username
        case 2:
            cell.valueLabel.text = UserInfoViewModel.shareInstance.userSex
        case 3:
            cell.valueLabel.text = UserInfoViewModel.shareInstance.userBithday
        default:
            cell.valueLabel.text = ""
        }
        
//        3.返回cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let logoutBtn = UIButton(type: .custom)
        logoutBtn.setTitle("退出", for: .normal)
        logoutBtn.backgroundColor = UIColor.red
        logoutBtn.addTarget(self, action: #selector(logoutBtnClicked(_:)), for: .touchUpInside)
        return logoutBtn
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
    
//    移除通知中心
    deinit {
        NotificationCenter.default.removeObserver(self)
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
extension ProfileViewController {
    
    func setupNavigationItem() {
//        1.设置标题
        navigationItem.title = "个人"
        
//        2.设置返回按钮
        navigationController?.navigationBar.setColor(color: UIColor.clear)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
        
//        3.修改信息
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "修改信息", style: .plain, target: self, action: #selector(modifyInfoBtnClicked(_:)))
    }

    func setupView() {
        tableView.separatorStyle = .singleLine
        avatarImageView.sd_setImage(with: UserInfoViewModel.shareInstance.userAvatarUrl, placeholderImage: UIImage(named: "avatar_default_big"))
    }
}

// MARK: - 监听通知
extension ProfileViewController {
    
    func setupNotifications() {
        
//        1.监听更新用户信息的通知
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserInfo(_:)), name: Notification.Name(rawValue: ModifyUserInfoNote), object: nil)
    }
}

// MARK: - 事件监听函数
extension ProfileViewController {
    
    @objc func updateUserInfo(_ sender: Any) {
        
        userInfo = UserInfoViewModel.shareInstance.userInfo
        avatarImageView.sd_setImage(with: UserInfoViewModel.shareInstance.userAvatarUrl, placeholderImage: UIImage(named: "avatar_default_big"))
        tableView.reloadData()
    }
    
    @objc func logoutBtnClicked(_ sender: Any) {
        
//        1.获取参数
        let userId: String = (UserInfoViewModel.shareInstance.userInfo?.userId)!
        let logoutDate: Date = Date()
        let fmt: DateFormatter = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd hh:mm:ss"
        fmt.timeZone = TimeZone(identifier: "Asia/Shanghai")
        fmt.locale = Locale(identifier: "zh_Hans_CN")
        
//        2.发送网络请求
        SVProgressHUD.showInfo(withStatus: "正在退出...")
        NetworkTools.shareInstance.addLoginAndLogoutLog(userId: userId, loginDate: nil, logoutDate: fmt.string(from: logoutDate), finished: {[weak self] (response, error) in
            SVProgressHUD.dismiss()
//          1.1.校验错误
            if error != nil {
                print(error ?? "error")
                return
            }
            
//          1.2.获取可选类型中的数据
            guard let responseDict = response else {
                return
            }
            
//          1.3.判断数据处理是否成功
            if (responseDict["result"]?.isEqual("failed"))! {
                
//            1.3.1.提示数据处理失败
                SVProgressHUD.setMinimumDismissTimeInterval(1)
                SVProgressHUD.showError(withStatus: responseDict["errorInfo"] as! String)
                
                return
            }
            
//            1.4.切换控制器
            let fileManager: FileManager = FileManager()
            try? fileManager.removeItem(atPath: UserInfoViewModel.userInfoPath)
            let chooseVc = ChooseLoginOrRegisterViewController()
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: chooseVc)
        })
    }
    
    @objc func modifyInfoBtnClicked(_ sender: Any) {
        let modifyInfoVc = ModifyProfileInfoViewController()
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(modifyInfoVc, animated: true)
        hidesBottomBarWhenPushed = false
    }
}
