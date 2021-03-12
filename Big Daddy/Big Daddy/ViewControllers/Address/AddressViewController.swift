//
//  AddressViewController.swift
//  Big Daddy
//
//  Created by Technomads on 24/02/21.
//

import UIKit
import MapKit

class AddressViewController: UIViewController {

    @IBOutlet weak var txtPickUpAddress: UITextField!
    @IBOutlet weak var lblAnd: UILabel!
    @IBOutlet weak var lineImageView: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var addressImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var topOfTopView: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    var isPickAddress:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle("Address")
        setLeftBarButton()
        setRightBarButton("notification") { [weak self](str) in
            let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
            notification.isBackButton = true
            self?.navigationController?.pushViewController(notification, animated: true)
        }
        txtSearch.setRightImageView(25, image: UIImage(named: "search")!)
        topView.dropShadowed(cornerRadius: 24, corners: [.topLeft,.topRight], borderColor: .clear, borderWidth: 0, shadowColor: .clear)
        if UIDevice.current.hasNotch {
            topOfTopView.constant = screenHeight-350
        } else {
            topOfTopView.constant = screenHeight-275
        }
        txtPickUpAddress.setRightImageView(25, image: UIImage(named: "pin")!)
        if isPickAddress {
            lblAddress.text = "Pickup\nAddress"
            addressImageView.image = UIImage(named: "pickup_truck")
        } else {
            lblAddress.text = "Delivery\nAddress"
            addressImageView.image = UIImage(named: "delivery_box")
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
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        if isPickAddress {
            let address = AddressViewController(nibName: "AddressViewController", bundle: nil)
            address.isBackButton = true
            address.isPickAddress = false
            self.navigationController?.pushViewController(address, animated: true)
        } else {
            let ordersummary = OrderDetailSummaryViewController(nibName: "OrderDetailSummaryViewController", bundle: nil)
            ordersummary.isBackButton = true
            self.navigationController?.pushViewController(ordersummary, animated: true)
        }
    }
    
    func moveUP() {
        UIView.animate(withDuration: 0.8) { [weak self] in
            self?.topOfTopView.constant = 0
            self?.lblAnd.alpha = 0
            self?.lineImageView.alpha = 0
            self?.indicatorView.alpha = 0
            self?.txtSearch.alpha = 0
            self?.setTitle("")
            self?.view.layoutIfNeeded()
        }
    }
    
    func moveDown(time:TimeInterval = 0.8) {
        UIView.animate(withDuration: time) { [weak self] in
            if UIDevice.current.hasNotch {
                self?.topOfTopView.constant = screenHeight-350
            } else {
                self?.topOfTopView.constant = screenHeight-275
            }
            self?.lblAnd.alpha = 1
            self?.lineImageView.alpha = 1
            self?.indicatorView.alpha = 1
            self?.txtSearch.alpha = 1
            self?.setTitle("Address")
            self?.view.layoutIfNeeded()
        }
    }
}
extension AddressViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 30 {
            moveUP()
        } else if scrollView.contentOffset.y < 30 {
            moveDown()
        }
    }
}
