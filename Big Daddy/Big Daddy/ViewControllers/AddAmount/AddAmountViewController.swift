//
//  AddAmountViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class AddAmountViewController: UIViewController {
 
    @IBOutlet weak var cardStackView: UIStackView!
    @IBOutlet weak var upiStackView: UIStackView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var upiView: UIView!
    @IBOutlet weak var cardIndicatorView: UIView!
    @IBOutlet weak var upiIndicatorView: UIView!
    @IBOutlet weak var btnCard: UIControl!
    @IBOutlet weak var btnUPI: UIControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle("Add Amount")
        setLeftBarButton()
        setRightBarButton("notification") { [weak self](str) in
            let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
            notification.isBackButton = true
            self?.navigationController?.pushViewController(notification, animated: true)
        }
        btnPaymentMethodAction(btnCard)
    }

    @IBAction func btnPaymentMethodAction(_ sender: UIControl) {
        if sender == btnCard {
            cardIndicatorView.alpha = 1
            upiIndicatorView.alpha = 0
            btnCard.dropShadowed(cornerRadius: 8, borderColor: .themeColor, borderWidth: 1, shadowColor: .clear)
            btnUPI.dropShadowed(cornerRadius: 8, borderColor: .lightGray, borderWidth: 0, shadowColor: .lightGray)
            btnCard.isSelected = true
            btnUPI.isSelected = false
            cardView.isHidden = false
            upiView.isHidden = true
            cardStackView.isHidden = false
            upiStackView.isHidden = true
        } else {
            cardIndicatorView.alpha = 0
            upiIndicatorView.alpha = 1
            btnUPI.dropShadowed(cornerRadius: 8, borderColor: .themeColor, borderWidth: 1, shadowColor: .clear)
            btnCard.dropShadowed(cornerRadius: 8, borderColor: .lightGray, borderWidth: 0, shadowColor: .lightGray )
            btnCard.isSelected = false
            btnUPI.isSelected = true
            cardView.isHidden = true
            upiView.isHidden = false
            cardStackView.isHidden = true
            upiStackView.isHidden = false
        }
    }
    
}
