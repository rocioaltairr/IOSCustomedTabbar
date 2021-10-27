//
//  MainTabBarController.swift
//  xway
//
//  Created by 2008007NB01 on 2020/9/28.
//  Copyright © 2020 2008007NB01. All rights reserved.
//

import UIKit

let arrTabsData = [["name":"訂票紀錄",
                    "img":UIImage(named:"tab1")!,
                    "imgSelected":UIImage(named:"tab1")!],
                   ["name":"林鐵訊息",
                    "img":UIImage(named:"tab2")!,
                    "imgSelected":UIImage(named:"tab2")!],
                   ["name":"個人資料",
                    "img":UIImage(named:"tab3")!,
                    "imgSelected":UIImage(named:"tab3")!],
                   ["name":"其他設定",
                    "img":UIImage(named:"tab4")!,
                    "imgSelected":UIImage(named:"tab4")!]]


class MainTabBarController: UITabBarController {
    
    static var tabBarHigh:CGFloat = 56
    override func viewDidLoad() {
        // 設定tabbarItem
        delegate = self
        
        let tabbarItem1 = UITabBarItem(title: arrTabData[0]["name"] as? String, image: arrTabData[0]["img"] as? UIImage, tag: 0)
        let tabbarItem2 = UITabBarItem(title: arrTabData[1]["name"] as? String, image: arrTabData[1]["img"] as? UIImage, tag: 1)
        let tabbarItem3 = UITabBarItem(title: arrTabData[2]["name"] as? String, image: arrTabData[3]["img"] as? UIImage, tag: 2)
        let tabbarItem4 = UITabBarItem(title: arrTabData[3]["name"] as? String, image: arrTabData[3]["img"] as? UIImage, tag: 3)
        
        // 設定tabbarController
        let vcTab1 = OrderVC()
        vcTab1.tabBarItem = tabbarItem1;
        
        
        let vcTab2 = OrderVC()
        vcTab2.tabBarItem = tabbarItem2;
        
        let vcTab3 = OrderVC()
        vcTab3.tabBarItem = tabbarItem3;
        
        
        let vcTab4 = OrderVC()
        vcTab4.tabBarItem = tabbarItem4;
        
        
        let tabControllers = [vcTab1,vcTab2,vcTab3,vcTab4]
        self.tabBarController?.setViewControllers(tabControllers, animated: true)
        self.viewControllers = tabControllers
          
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // view 出現時set tabview 外觀
        let tabbarView = MainTabbarView.sharedView(
            frame: CGRect(x: 0,
                          y: self.view.bounds.size.height - MainTabBarController.tabBarHigh,
                          width: self.view.frame.width,
                          height: MainTabBarController.tabBarHigh))
        tabbarView.setTab(self.selectedIndex)
    }
    
    override func viewWillLayoutSubviews() {
        // view裡的subview
        MainTabbarView.showView(self)
    }
    
    override func loadView() {
        super.loadView()
    }
    

    
    
    public func setTab(_ index: Int) {
        if let tabbarView = MainTabbarView.shared {
            tabbarView.setTab(index)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

//MARK: - UITabBarControllerDelegate
extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
}

//MARK: - TabbarView
class MainTabbarView: UIView {
    
    static var shared: MainTabbarView?
    var vcTab: UITabBarController?
    var intTabNum = 4
    static var tabBarHigh:CGFloat = 56
    let vwBg: UIView = UIView();
    static var shadowView: UIView = UIView()
    
    let arrTabBtn: NSMutableArray = NSMutableArray()
    let arrTabIv: NSMutableArray = NSMutableArray()
    let arrTabLb: NSMutableArray = NSMutableArray()
    
    static func sharedView(frame: CGRect) -> MainTabbarView {
        if shared == nil {
            shared = MainTabbarView.init(frame: frame)
        }
        return shared!
    }
    
    //MARK: initView
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        vwBg.backgroundColor = .white
        
        self.translatesAutoresizingMaskIntoConstraints = false
        vwBg.translatesAutoresizingMaskIntoConstraints = false
        
        MainTabbarView.shadowView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 100)
        MainTabbarView.shadowView.backgroundColor = .white
        MainTabbarView.shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        MainTabbarView.shadowView.layer.shadowOpacity = 0.3
        MainTabbarView.shadowView.layer.shadowOffset = CGSize(width: 0, height: -2)
        MainTabbarView.shadowView.layer.shadowRadius = 2
        self.addSubview(MainTabbarView.shadowView)
        
        let ivW = (frame.size.height/2)*69/69
        for i in 0 ..< intTabNum {
            
            let btnTab: UIButton = UIButton()
            btnTab.frame = CGRect(x: UIScreen.main.bounds.width / CGFloat(intTabNum) * CGFloat(i),
                                  y: 0,
                                  width: UIScreen.main.bounds.width / CGFloat(intTabNum),
                                  height: frame.size.height)
            btnTab.tag = i
            btnTab.addTarget(self, action: #selector(btnTab_Click(_:)), for: UIControl.Event.touchUpInside)
            
            let ivTab: UIImageView = UIImageView()
            ivTab.frame = CGRect(x: btnTab.frame.origin.x + btnTab.frame.size.width/2 - ivW/2,
                                 y: 8,//frame.size.height/2/2 - 8,
                                 width: ivW,
                                 height: frame.size.height/2-2)//frame.size.height/2)
            ivTab.tag = i
            
            let lbTab: UILabel = UILabel()
            lbTab.frame = CGRect(x: btnTab.frame.origin.x ,
                                 y: btnTab.frame.size.height/2+2,//frame.size.height-18,
                                 width: btnTab.frame.size.width,
                                 height: btnTab.frame.size.height/2)//20)
            lbTab.tag = i
            lbTab.font = UIFont.systemFont(ofSize: 13.0)
            lbTab.textColor = UIColor.blue
            lbTab.textAlignment = NSTextAlignment.center
            
            lbTab.text = (arrTabData[i]["name"] as! String)
            if i == 0 {
                ivTab.image = (arrTabData[0]["imgSelected"] as! UIImage)
                btnTab.isSelected = true
                btnTab.backgroundColor = UIColor.clear
                lbTab.textColor = UIColor.white
            } else {
                ivTab.image = (arrTabData[i]["img"] as! UIImage)
                btnTab.backgroundColor = UIColor.clear
                lbTab.textColor = UIColor.gray
            }
            
            arrTabBtn.add(btnTab)
            arrTabIv.add(ivTab)
            arrTabLb.add(lbTab)
            
            self.addSubview(btnTab)
            self.addSubview(ivTab)
            self.addSubview(lbTab)
            
            
            
            self.translatesAutoresizingMaskIntoConstraints = false
            
        }
       
    }
    
    //MARK: showTabBarView
    
    static func showView(_ vc: UITabBarController) {
        let view = vc.view!
        let tabbarView = MainTabbarView.sharedView(
            frame: CGRect(x: 0,
                          y: view.bounds.size.height - tabBarHigh,
                          width: view.frame.width,
                          height: tabBarHigh))
        tabbarView.vwBg.frame =
            CGRect(x: 0,
                   y: tabbarView.frame.origin.y + tabbarView.frame.size.height,
                   width: tabbarView.frame.size.width,
                   height: tabBarHigh)
        
        view.addSubview(tabbarView.vwBg)
        view.addSubview(tabbarView)
        tabbarView.removeConstraints(tabbarView.constraints)
        tabbarView.vwBg.removeConstraints(tabbarView.vwBg.constraints)
        tabbarView.vcTab = vc
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 按下tab狀態
    @objc func btnTab_Click(_ sender: UIButton) {
        setTab(sender.tag)
    }
    
    //MARK: setTab
    func setTab(_ index: Int) {
        
        self.vcTab?.selectedIndex = index
        
        for btn in arrTabBtn {
            if let btn:UIButton = btn as? UIButton {
                if btn.tag == index {
                    btn.isSelected = true
                    //                    btn.backgroundColor = UIColor.blue
                } else {
                    btn.isSelected = false
                    //                    btn.backgroundColor = UIColor.white
                }
            }
        }
        
        for iv in arrTabIv {
            if let iv:UIImageView = iv as? UIImageView {
                iv.contentMode = .scaleAspectFit
                if iv.tag == index {
                    iv.image = (arrTabData[iv.tag]["imgSelected"] as! UIImage)
                } else {
                    iv.image = (arrTabData[iv.tag]["img"] as! UIImage)
                }
            }
        }
        
        for lb in arrTabLb {
            if let lb: UILabel = lb as? UILabel {
                if lb.tag == index {
                    lb.textColor = UIColor(red: 213/255, green: 116/255, blue: 32/255, alpha: 1.0)
                } else {
                    lb.textColor = .black
                }
            }
        }
    }
    
//    func setTab_Click(sender: UIButton) {
//
//    }
    
    
}
