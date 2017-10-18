//
//  SearchViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 16/10/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - 自定义属性
    lazy var carInfoSearchBtn: UIButton = UIButton(type: .custom)
    lazy var carOwnerInfoSearchBtn: UIButton = UIButton(type: .custom)
    lazy var lawBreakerInfoSearchByICBtn: UIButton = UIButton(type: .custom)
    lazy var lawBreakerInfoSearchByCarIdBtn: UIButton = UIButton(type: .custom)
    lazy var lawBreakerInfoSearchByCarOwnerNameBtn: UIButton = UIButton(type: .custom)
    
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
extension SearchViewController {
    
    func setupNavigationItem() {
        
//        1.设置标题
        navigationItem.title = "查询"
        
//        2.设置navigationBar颜色
        navigationController?.navigationBar.setColor(color: UIColor.clear)
        
//        3.设置返回按钮
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
    }
    
    func setupView() {
        
//        1.添加子控件
        view.addSubview(carInfoSearchBtn)
        view.addSubview(carOwnerInfoSearchBtn)
        view.addSubview(lawBreakerInfoSearchByICBtn)
        view.addSubview(lawBreakerInfoSearchByCarIdBtn)
        view.addSubview(lawBreakerInfoSearchByCarOwnerNameBtn)
        
//        2.设置frame
        carOwnerInfoSearchBtn.snp.makeConstraints { (make) in
            make.top.equalTo(224)
            make.left.equalTo(62)
            make.right.equalTo(-62)
            make.height.equalTo(40)
        }
        carInfoSearchBtn.snp.makeConstraints { (make) in
            make.top.equalTo(269)
            make.left.equalTo(62)
            make.right.equalTo(-62)
            make.height.equalTo(40)
        }
        lawBreakerInfoSearchByICBtn.snp.makeConstraints { (make) in
            make.top.equalTo(314)
            make.left.equalTo(62)
            make.right.equalTo(-62)
            make.height.equalTo(40)
        }
        lawBreakerInfoSearchByCarIdBtn.snp.makeConstraints { (make) in
            make.top.equalTo(359)
            make.left.equalTo(62)
            make.right.equalTo(-62)
            make.height.equalTo(40)
        }
        lawBreakerInfoSearchByCarOwnerNameBtn.snp.makeConstraints { (make) in
            make.top.equalTo(404)
            make.left.equalTo(62)
            make.right.equalTo(-62)
            make.height.equalTo(40)
        }
        
        //        3.设置属性
        carOwnerInfoSearchBtn.setupBtnProperty(viewController: self, action: #selector(carOwnerInfoSearchBtnClicked(_:)), bgColor: UIColor.colorWithHex(hex: kButtonHighlightBackgroundColor, alpha: 1.0), title: "车主信息查询")
        
        carInfoSearchBtn.setupBtnProperty(viewController: self, action: #selector(carInfoSearchBtnClicked(_:)), bgColor: UIColor.colorWithHex(hex: kButtonHighlightBackgroundColor, alpha: 1.0), title: "车辆信息查询")
        
        lawBreakerInfoSearchByICBtn.setupBtnProperty(viewController: self, action: #selector(lawBreakerInfoSearchByICBtnClicked(_:)), bgColor: UIColor.colorWithHex(hex: kLawBreakerBtnBackGroundColor, alpha: 1.0), title: "按身份证号码查询违规信息")
        
        lawBreakerInfoSearchByCarIdBtn.setupBtnProperty(viewController: self, action: #selector(lawBreakerInfoSearchByCarIdBtnClicked(_:)), bgColor: UIColor.colorWithHex(hex: kLawBreakerBtnBackGroundColor, alpha: 1.0), title: "按车牌号查询违规信息")
        
        lawBreakerInfoSearchByCarOwnerNameBtn.setupBtnProperty(viewController: self, action: #selector(lawBreakerInfoSearchByCarOwnerNameBtnClicked(_:)), bgColor: UIColor.colorWithHex(hex: kLawBreakerBtnBackGroundColor, alpha: 1.0), title: "按车主名查询违规信息")
    }
}

// MARK: - 事件监听函数
extension SearchViewController {
    @objc func carInfoSearchBtnClicked(_ sender: Any) {
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(CarInfoSearchViewController(), animated: true)
    }
    
    @objc func carOwnerInfoSearchBtnClicked(_ sender: Any) {
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(CarOwnerInfoSearchViewController(), animated: true)
    }
    
    @objc func lawBreakerInfoSearchByICBtnClicked(_ sender: Any) {
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(LawBreakerInfoSearchByICViewController(), animated: true)
    }
    
    @objc func lawBreakerInfoSearchByCarIdBtnClicked(_ sender: Any) {
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(LawBreakerInfoSearchByCarIdViewController(), animated: true)
    }
    
    @objc func lawBreakerInfoSearchByCarOwnerNameBtnClicked(_ sender: Any) {
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(LawBreakerInfoSearchByCarOwnerNameViewController(), animated: true)
    }
}
