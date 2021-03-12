//
//  TrackOrderDetailViewController.swift
//  Big Daddy
//
//  Created by Technomads on 22/02/21.
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
