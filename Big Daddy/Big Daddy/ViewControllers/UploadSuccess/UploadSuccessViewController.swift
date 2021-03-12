//
//  UploadSuccessViewController.swift
//  Big Daddy
//
//  Created by Technomads on 23/02/21.
//

import UIKit

class UploadSuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftBarButton()
        setRightBarButton("notification") {[weak self] (str) in
            let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
            notification.isBackButton = true
            self?.navigationController?.pushViewController(notification, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnBackToHomeAction(_ sender: UIButton) {
        appDelegate().showDash()
    }
}
