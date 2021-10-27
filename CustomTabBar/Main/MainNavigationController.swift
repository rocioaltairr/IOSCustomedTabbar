//
//  MainNavigationController.swift
//  Afrch
//
//  Created by 忠義 on 2020/10/15.
//

import UIKit

extension UIAlertController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    open override var shouldAutorotate: Bool {
        return false
    }
}

class MainNavigationController: UINavigationController {

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


extension MainNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.isSwitching = false; // 3. 還原狀態
    }
}
