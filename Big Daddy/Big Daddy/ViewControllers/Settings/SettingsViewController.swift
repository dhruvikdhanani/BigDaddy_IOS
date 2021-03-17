//
//  SettingsViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class SettingsViewController: UIViewController {

    let presenter = Presenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .themeColor
        self.view.viewWithTag(100)?.dropShadowed(cornerRadius: 24, corners: [.topRight,.topLeft], borderColor: UIColor.clear, borderWidth: 0, shadowColor: .clear)
        
        self.view.viewWithTag(1001)?.dropShadowed(cornerRadius: 8, borderColor: UIColor.clear, borderWidth: 0, shadowColor: .lightGray)
        
        self.view.viewWithTag(1002)?.dropShadowed(cornerRadius: 8, borderColor: UIColor.clear, borderWidth: 0, shadowColor: .lightGray)
        
        self.view.viewWithTag(1003)?.dropShadowed(cornerRadius: 8, borderColor: UIColor.clear, borderWidth: 0, shadowColor: .lightGray)
        
        self.view.viewWithTag(1004)?.dropShadowed(cornerRadius: 8, borderColor: UIColor.clear, borderWidth: 0, shadowColor: .lightGray)
        
        self.view.viewWithTag(1005)?.dropShadowed(cornerRadius: 8, borderColor: UIColor.clear, borderWidth: 0, shadowColor: .lightGray)
    }
    
    @IBAction func btnMenuAction(_ sender: UIButton) {
        sideMenuViewController?.showLeftMenuViewController()
    }
    
    @IBAction func btnNotificationAction(_ sender: UIButton) {
        let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
        notification.isBackButton = true
        self.navigationController?.pushViewController(notification, animated: true)
    }
    
    @IBAction func btnAboutUsAction(_ sender: UIControl) {
        let about = AboutUsViewController(nibName: "AboutUsViewController", bundle: nil)
        about.isBackButton = true
        about.notificationBlock = { [weak self] () in
            self?.btnNotificationAction(UIButton())
        }
//        self.navigationController?.pushViewController(about, animated: true)
        presenter.present(about, from: self)
    }
    
    @IBAction func btnContactUsAction(_ sender: UIControl) {
        let contact = ContactUsViewController(nibName: "ContactUsViewController", bundle: nil)
        contact.isBackButton = true
        contact.notificationBlock = { [weak self] () in
            self?.btnNotificationAction(UIButton())
        }
//        self.navigationController?.pushViewController(contact, animated: true)
        presenter.present(contact, from: self)
    }
    
    
    
    @IBAction func btnFeedbackAction(_ sender: UIControl) {
        let feedback = FeedbackViewController(nibName: "FeedbackViewController", bundle: nil)
        feedback.isBackButton = true
        self.navigationController?.pushViewController(feedback, animated: true)
//        presenter.present(feedback, from: self)
    }
    
    @IBAction func btnLogoutAction(_ sender: UIButton) {
        appDelegate().showLogin()
    }
}
