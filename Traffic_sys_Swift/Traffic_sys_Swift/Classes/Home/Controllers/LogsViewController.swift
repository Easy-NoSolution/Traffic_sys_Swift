//
//  LogsViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 16/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

class LogsViewController: UITableViewController {

    // MARK: - 自定义属性
    lazy var userId: String = (UserInfoViewModel.shareInstance.userInfo?.userId)!
    lazy var offset: NSInteger = 0
    lazy var rows: NSInteger = 10
    lazy var logsDataArray: Array = Array<LogViewModel>()
    
    // MARK: - 系统回调函数
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0)
        setupNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        1.添加下拉刷新控件
        let header: MJRefreshNormalHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadLogsData))
        header.setTitle("下拉刷新", for: .idle)
        header.setTitle("松手开始刷新", for: .pulling)
        header.setTitle("加载中...", for: .refreshing)
        
        header.beginRefreshing()
        self.tableView.mj_header = header
        
//        2.添加上拉刷新控件
        let footer: MJRefreshAutoNormalFooter = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadNextPageLogsData))
        footer.setTitle("上拉刷新", for: .idle)
        footer.setTitle("松手开始刷新", for: .pulling)
        footer.setTitle("加载中...", for: .refreshing)
        
        self.tableView.mj_footer = footer
        
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
        return logsDataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        1.创建cell
        let cell = LogsViewCell.checkInCellWithTableView(tableView: tableView) as! LogsViewCell

//        2.赋值
        let logVM = logsDataArray[indexPath.row]
        if logVM.loginDate == nil {
            cell.titleLabel.text = "退出时间"
            cell.valueLabel.text = logVM.logoutDate!
        } else {
            cell.titleLabel.text = "登录时间"
            cell.valueLabel.text = logVM.loginDate!
        }

//        3.返回cell
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
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
extension LogsViewController {
    
    func setupNavigationItem() {
//        1.设置标题
        navigationItem.title = "日志"
        
//        2.设置navigationitem透明度
        navigationController?.navigationBar.setColor(color: UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1.0))
    }
}

// MARK: - 数据请求
extension LogsViewController {
    
    @objc func loadLogsData() {
//        1.清空数据
        offset = 0
        logsDataArray.removeAll()
        
//        2.发送网络请求
        SVProgressHUD.showInfo(withStatus: "正在获取登录日志...")
        NetworkTools.shareInstance.loadLogs(userId: userId, offset: offset, rows: rows) {[weak self] (response, error) in
            SVProgressHUD.dismiss()
//            2.1.校验参数
            if error != nil {
                print(error ?? "error")
                return
            }
            
//            2.2.获取请求的值
            guard let responseDict = response else {
                return
            }
            
//            2.3.字典转模型
            for dic in responseDict["logs"] as! Array<[String : Any]> {
                let log = Log(dict: dic)
                let logVM = LogViewModel(log: log)
                self?.logsDataArray.append(logVM)
            }
            
//            2.4.判断数据处理是否成功
            if (responseDict["result"]?.isEqual("failed"))! {
                
//                2.4.1.提示数据处理失败
                SVProgressHUD.setMinimumDismissTimeInterval(1)
                SVProgressHUD.showError(withStatus: responseDict["errorInfo"] as! String)
                
                return
            }
            
//            2.5.更新数据
            self?.tableView.reloadData()
            self?.tableView.mj_header.endRefreshing()
        }
    }
    
    @objc func loadNextPageLogsData() {
//        1.设置参数
        offset = logsDataArray.count
        
//        2.发送网络请求
        NetworkTools.shareInstance.loadLogs(userId: userId, offset: offset, rows: rows) {[weak self] (response, error) in
//            2.1.校验参数
            if error != nil {
                print(error ?? "error")
                return
            }
            
//            2.2.获取请求的值
            guard let responseDict = response else {
                return
            }
            
//            2.3.字典转模型
            for dic in responseDict["logs"] as! Array<[String : Any]> {
                let log = Log(dict: dic)
                let logVM = LogViewModel(log: log)
                self?.logsDataArray.append(logVM)
            }
            
//            2.4.更新数据
            self?.tableView.reloadData()
            self?.tableView.mj_footer.endRefreshing()
        }
    }
}
