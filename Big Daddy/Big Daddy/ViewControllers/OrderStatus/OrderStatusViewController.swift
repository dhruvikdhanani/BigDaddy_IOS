//
//  OrderStatusViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class OrderStatusViewController: UIViewController {

    @IBOutlet weak var btnOrderList: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle("Order")
        setLeftBarButton()
        setRightBarButton("notification") { [weak self](str) in
            let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
            notification.isBackButton = true
            self?.navigationController?.pushViewController(notification, animated: true)
        }
        btnOrderList.setHyperLink()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnTrackOrderAction(_ sender: UIButton) { 
        if let menu = appDelegate().sideMenuViewController?.leftMenuViewController as? SideMenuViewController {
            menu.handleTouch(at: 3)
        }
    }
    
    @IBAction func btnOrderListAction(_ sender: UIButton) {
        if let menu = appDelegate().sideMenuViewController?.leftMenuViewController as? SideMenuViewController {
            menu.handleTouch(at: 2)
        }
    }
    
}
