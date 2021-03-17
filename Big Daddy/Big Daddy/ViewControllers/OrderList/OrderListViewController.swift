//
//  OrderListViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class OrderListViewController: UIViewController {
    
    @IBOutlet weak var topOfMainHeaderLabel: NSLayoutConstraint!
    @IBOutlet weak var topOfHeaderView: NSLayoutConstraint!
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var orderListTableView: UITableView!
    var selectedIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        orderListTableView.register(UINib(nibName: OrderListCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: OrderListCell.reuseIdentifier)
        orderListTableView.tableFooterView = UIView(frame: .zero)
        orderListTableView.delegate = self
        orderListTableView.dataSource = self
        setupView()
        headerView.dropShadowed(cornerRadius: 24, corners: [.topLeft,.topRight], borderColor: .clear, borderWidth: 0, shadowColor: .clear)
    }
    
    @IBAction func btnMenuAction(_ sender: UIButton) {
        sideMenuViewController?.showLeftMenuViewController()
    }
    
    @IBAction func btnNotificationAction(_ sender: UIButton) {
        let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
        notification.isBackButton = true
        self.navigationController?.pushViewController(notification, animated: true)
    }
    
    @IBAction func btnFilterAction(_ sender: UIButton) {
        let popover = Popover()
        popover.arrowSize = CGSize(width: 0, height: 0)
        popover.cornerRadiuss = 16
        let filter:OrderFilterView = UIView.fromNib()
        filter.frame = CGRect(x: 0, y: 0, width: 260, height: 250)
        filter.selectedIndex = selectedIndex
        filter.setupSelection()
        filter.btnSelected = { [weak self](index) in
            self?.selectedIndex = index
            popover.dismiss()
//            API Call here for filter as per index of buttons
        }
        popover.show(filter, point: CGPoint(x: sender.globalFrame!.minX, y: sender.globalFrame!.maxY+16))
    }
    
    func setupView() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        headerView.addGestureRecognizer(gestureRecognizer)
        headerView.isUserInteractionEnabled = true
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let velocity = gestureRecognizer.velocity(in: headerView)
        if(velocity.y < 0) {
            moveUP()
        } else {
            moveDown()
        }
    }
    
    func moveUP() {
        UIView.animate(withDuration: 0.8) { [weak self] in
            self?.topOfHeaderView.constant = 0
            self?.indicatorView.alpha = 0
            self?.lblHeaderTitle.alpha = 0
            self?.topOfMainHeaderLabel.constant = 0
            self?.bgImageView.alpha = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    func moveDown(time:TimeInterval = 0.8) {
        UIView.animate(withDuration: time) { [weak self] in
            self?.topOfHeaderView.constant = 150
            self?.indicatorView.alpha = 1
            self?.lblHeaderTitle.alpha = 1
            self?.topOfMainHeaderLabel.constant = 64
            self?.bgImageView.alpha = 1
            self?.view.layoutIfNeeded()
        }
    }
}

extension OrderListViewController:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderListCell.reuseIdentifier, for: indexPath) as! OrderListCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetail = OrderDetailViewController.init(nibName: "OrderDetailViewController", bundle: nil)
        orderDetail.isBackButton = true
        self.navigationController?.pushViewController(orderDetail, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 50 {
            moveUP()
        } else if scrollView.contentOffset.y < 50 {
            moveDown()
        }
    }
    
}
