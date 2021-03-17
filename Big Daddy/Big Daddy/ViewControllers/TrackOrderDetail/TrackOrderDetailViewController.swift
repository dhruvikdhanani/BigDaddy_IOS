//
//  TrackOrderDetailViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class TrackOrderDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftBarButton()
        setRightBarButton("notification") {[weak self] (str) in
            let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
            notification.isBackButton = true
            self?.navigationController?.pushViewController(notification, animated: true)
        }
    }
 

}
