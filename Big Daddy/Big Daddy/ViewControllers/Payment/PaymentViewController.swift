//
//  PaymentViewController.swift
//  Big Daddy
//
//  Created by Technomads on 25/02/21.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var cardStackView: UIStackView!
    @IBOutlet weak var upiStackView: UIStackView!
    @IBOutlet weak var cardIndicatorView: UIView!
    @IBOutlet weak var upiIndicatorView: UIView!
    @IBOutlet weak var codIndicatorView: UIView!
    @IBOutlet weak var btnCard: UIControl!
    @IBOutlet weak var btnUPI: UIControl!
    @IBOutlet weak var btnCOD: UIControl!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var upiView: UIView!
    @IBOutlet weak var codView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle("Payment")
        setLeftBarButton()
        setRightBarButton("notification") { [weak self](str) in
            let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
            notification.isBackButton = true
            self?.navigationController?.pushViewController(notification, animated: true)
        }
        btnPaymentMethodAction(btnCard)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnPaymentMethodAction(_ sender: UIControl) {
        if sender == btnCard {
            cardIndicatorView.alpha = 1
            upiIndicatorView.alpha = 0
            codIndicatorView.alpha = 0
            btnCard.dropShadowed(cornerRadius: 8, borderColor: .themeColor, borderWidth: 1, shadowColor: .clear)
            btnUPI.dropShadowed(cornerRadius: 8, borderColor: .lightGray, borderWidth: 0, shadowColor: .lightGray)
            btnCOD.dropShadowed(cornerRadius: 8, borderColor: .lightGray, borderWidth: 0, shadowColor: .lightGray)
            btnCard.isSelected = true
            btnUPI.isSelected = false
            btnCOD.isSelected = false
            cardView.isHidden = false
            upiView.isHidden = true
            codView.isHidden = true
            cardStackView.isHidden = false
            upiStackView.isHidden = true
        } else if sender == btnUPI {
            cardIndicatorView.alpha = 0
            upiIndicatorView.alpha = 1
            codIndicatorView.alpha = 0
            btnUPI.dropShadowed(cornerRadius: 8, borderColor: .themeColor, borderWidth: 1, shadowColor: .clear)
            btnCard.dropShadowed(cornerRadius: 8, borderColor: .lightGray, borderWidth: 0, shadowColor: .lightGray)
            btnCOD.dropShadowed(cornerRadius: 8, borderColor: .lightGray, borderWidth: 0, shadowColor: .lightGray)
            btnCard.isSelected = false
            btnUPI.isSelected = true
            btnCOD.isSelected = false
            cardView.isHidden = true
            upiView.isHidden = false
            codView.isHidden = true
            cardStackView.isHidden = true
            upiStackView.isHidden = false
        } else if sender == btnCOD {
            cardIndicatorView.alpha = 0
            upiIndicatorView.alpha = 0
            codIndicatorView.alpha = 1
            btnCard.dropShadowed(cornerRadius: 8, borderColor: .lightGray, borderWidth: 0, shadowColor: .lightGray)
            btnUPI.dropShadowed(cornerRadius: 8, borderColor: .lightGray, borderWidth: 0, shadowColor: .lightGray)
            btnCOD.dropShadowed(cornerRadius: 8, borderColor: .themeColor, borderWidth: 1, shadowColor: .clear)
            btnCard.isSelected = false
            btnUPI.isSelected = false
            btnCOD.isSelected = true
            cardView.isHidden = true
            upiView.isHidden = true
            codView.isHidden = false
            cardStackView.isHidden = true
            upiStackView.isHidden = true
        }
    }

    @IBAction func btnPlaceOrderAction(_ sender: UIButton) {
        let orderStatus = OrderStatusViewController(nibName: "OrderStatusViewController", bundle: nil)
        orderStatus.isBackButton = true
        self.navigationController?.pushViewController(orderStatus, animated: true)
    }
}
