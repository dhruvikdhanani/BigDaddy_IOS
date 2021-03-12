//
//  AboutUsViewController.swift
//  Big Daddy
//
//  Created by Technomads on 18/02/21.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var topOfTitleLabel: NSLayoutConstraint!
    var notificationBlock:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftBarButton()
        setTitle("About Us")
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func btnNotificationAction(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            guard let notify = self?.notificationBlock else { return }
            notify()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.topOfTitleLabel.constant = 8
            self?.view.layoutIfNeeded()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.topOfTitleLabel.constant = 200
            self?.view.layoutIfNeeded()
        }
    }

}
