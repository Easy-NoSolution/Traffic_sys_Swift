//
//  TabBarViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 27/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        1.设置属性
//        tabBar.tintColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1)

//        2.添加控制器
        setupChildViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - 设置子控制器
extension TabBarViewController {
    
    func setupChildViewController() {
//        1.首页
        addChildViewController(imageName: "tabbar_home", controller: HomeViewController(), title: "首页")
        
//        2.个人
        addChildViewController(imageName: "tabbar_profile", controller: ProfileViewController(), title: "个人")
    }
    
    func addChildViewController(imageName: String, controller: UIViewController, title: String) {
//        1.设置属性
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(named: imageName)
        controller.tabBarItem.selectedImage = UIImage(named: "\(imageName)_highlighted")
        
//        2.添加控制器
        let nav = UINavigationController(rootViewController: controller)
        addChildViewController(nav)
    }
}
