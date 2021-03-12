//
//  OrderDetailSummaryViewController.swift
//  Big Daddy
//
//  Created by Technomads on 25/02/21.
//

import UIKit
import MapKit

class OrderDetailSummaryViewController: UIViewController {

    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var orderDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle("Order Details")
        setLeftBarButton()
        setRightBarButton("notification") { [weak self](str) in
            let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
            notification.isBackButton = true
            self?.navigationController?.pushViewController(notification, animated: true)
        }
        orderDetailTableView.register(UINib(nibName: OrderDetailCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: OrderDetailCell.reuseIdentifier)
        heightOfTableView.constant = 165
        orderDetailTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: orderDetailTableView.frame.size.width, height: 1))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        let payment = PaymentViewController(nibName: "PaymentViewController", bundle: nil)
        payment.isBackButton = true
        self.navigationController?.pushViewController(payment, animated: true)
    }
    
}

extension OrderDetailSummaryViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailCell.reuseIdentifier, for: indexPath) as! OrderDetailCell
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:ParcelDetailHeaderView = UIView.fromNib()
        return view
    }
}
