//
//  MainNavC.swift
//  xway
//
//  Created by 2008007NB01 on 2020/11/25.
//  Copyright © 2020 2008007NB01. All rights reserved.
//

import UIKit

class MainNavC: UINavigationController {

    var isSwitching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if (animated) {
            if (self.isSwitching) {
                return; // 1. 如果是動畫，並且正在切換，直接忽略
            }
            self.isSwitching = true // 2. 否則修改狀態
        }
        
    }

    override var shouldAutorotate: Bool {
        return self.visibleViewController!.shouldAutorotate
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if self.visibleViewController != nil {
            return self.visibleViewController!.supportedInterfaceOrientations
        }
        return .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.visibleViewController!.preferredInterfaceOrientationForPresentation
    }

}



extension MainNavC: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.isSwitching = false; // 3. 還原狀態
    }
}
