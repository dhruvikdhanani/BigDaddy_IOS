//
//  AppNavigationViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class AppNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .themeFontColor
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.themeFontColor,
         NSAttributedString.Key.font: UIFont(name: "AbrilFatface-Regular", size: 24)!]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
}

extension UIViewController {
    func setTitle(_ title:String) {
        self.title = title
        self.tabBarItem.title = nil
    }
    
    func setLeftBarButton(onCompletion: ((String)->Void)? = nil ) {
        let btn:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        if isBackButton {
            btn.setImage(UIImage(named: "ic_back_arrow"), for: .normal)
        } else {
            btn.setImage(UIImage(named: "ic_menu"), for: .normal)
        }
        
        btn.block_setAction { [weak self] (control) in
            if self!.isBackButton {
                self?.navigationController?.popViewController(animated: true)
                onCompletion?("")
            } else {
                self?.sideMenuViewController?.showLeftMenuViewController()
            }
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    func setRightBarButton(_ image:String, onCompletion: @escaping ((String)->Void) ) {
        let btn:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btn.setImage(UIImage(named: image), for: .normal)
        
        btn.block_setAction { (control) in
            onCompletion(image)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    func setRightBarMulti(_ image1:String,_ image2: String, onCompletion: @escaping ((String)->Void) ) {
        let btn1 = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btn1.setImage(UIImage(named: image1), for: .normal)
        
        btn1.block_setAction { (control) in
            onCompletion(image1)
        }
        
        let btn2:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btn2.setImage(UIImage(named: image2), for: .normal)
        
        btn2.block_setAction { (control) in
            onCompletion(image2)
        }
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: btn1), UIBarButtonItem(customView: btn2)]
    }
    
}
