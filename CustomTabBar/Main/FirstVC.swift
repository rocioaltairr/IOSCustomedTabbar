//
//  FirstVC.swift
//  xway
//
//  Created by 2008007NB01 on 2020/11/25.
//  Copyright © 2020 2008007NB01. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pushVC()
        // Do any additional setup after loading the view.
    }


    func pushVC() {
        let vcTab = MainTabBarController()
        vcTab.selectedIndex = 0
        let navController = UINavigationController(rootViewController: vcTab)
        // 將navigationBar透明化
        navController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.isTranslucent = true
        navController.view.backgroundColor = UIColor.clear
        navController.navigationBar.isHidden = true
        UIApplication.shared.keyWindow?.rootViewController = navController
        
    }

}
