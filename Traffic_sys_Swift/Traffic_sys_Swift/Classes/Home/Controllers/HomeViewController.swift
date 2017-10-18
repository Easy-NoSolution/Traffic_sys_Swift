//
//  HomeViewController.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 28/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - 自定义属性
    lazy var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    let data = [["search1", "查询"], ["register", "登记"], ["log", "日志"]]
    
    // MARK: - 系统回调函数
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor.colorWithHex(hex: kBackGroundColor, alpha: 1)
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
extension HomeViewController {
    
    func setupNavigationItem() {
//        1.设置标题
        navigationItem.title = "主页"
        
//        2.设置下一个界面的返回按钮
        navigationController?.navigationBar.setColor(color: UIColor.clear)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
    }
    
    func setupView() {
//        1.添加控制器
        view.addSubview(collectionView)
        
//        2.设置frame
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-48)
        }
        
//        3.设置属性
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: kHomeCellIdentifier)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 85.0
        layout.minimumInteritemSpacing = 30.0
        layout.itemSize = CGSize(width: 56, height: 85)
        layout.sectionInset = UIEdgeInsetsMake(29, 34, 29, 34)
        
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kHomeCellIdentifier, for: indexPath) as! HomeCollectionViewCell
        collectionViewCell.imageView.image = UIImage(named: data[indexPath.row][0])
        collectionViewCell.titleLabel.text = data[indexPath.row][1]
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            pushViewController(viewController: SearchViewController())
        case 1:
            pushViewController(viewController: CheckInViewController())
        case 2:
            pushViewController(viewController: LogsViewController())
        default:
            break
        }
    }
}

// MARK: - 自定义函数
extension HomeViewController {
    
    func pushViewController(viewController: UIViewController) {
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
        hidesBottomBarWhenPushed = false
    }
}
