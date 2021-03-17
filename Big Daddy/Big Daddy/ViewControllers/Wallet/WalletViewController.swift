//
//  WalletViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class WalletViewController: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var topOfTitle: NSLayoutConstraint!
    @IBOutlet weak var topOfTopView: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var walletTableView: UITableView!
    var arrWallet:[typeAliasDictionary] = [typeAliasDictionary]()
    var arrHeight:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnReset.setHyperLink()
        topView.dropShadowed(cornerRadius: 24, corners: [.topRight,.topLeft], borderColor: .clear, borderWidth: 0, shadowColor: .clear)
        setupView()
        walletTableView.register(UINib(nibName: WalletCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: WalletCell.reuseIdentifier)
        walletTableView.tableFooterView = UIView(frame: .zero)
        arrWallet = [typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(),typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary()]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnOpenCalenderAction(_ sender: UIButton) {
        let popover = Popover()
        popover.arrowSize = CGSize(width: 0, height: 0)
        popover.cornerRadiuss = 16
        let calender:CalenderView = UIView.fromNib()
        calender.frame = CGRect(x: 0, y: 0, width: screenWidth-64, height: 300)
        popover.show(calender, point: CGPoint(x: sender.globalFrame!.minX, y: sender.globalFrame!.maxY+16))
    }
    
    @IBAction func btnShowMenuAction(_ sender: UIButton) {
        sideMenuViewController?.showLeftMenuViewController()
    }
    
    @IBAction func btnAddAmountAction(_ sender: UIButton) {
        let addAmount = AddAmountViewController(nibName: "AddAmountViewController", bundle: nil)
        addAmount.isBackButton = true
        self.navigationController?.pushViewController(addAmount, animated: true)
    }
    
    @IBAction func btnNotificationAction(_ sender: UIButton) {
        let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
        notification.isBackButton = true
        self.navigationController?.pushViewController(notification, animated: true)
    }
    
    func setupView() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        topView.addGestureRecognizer(gestureRecognizer)
        topView.isUserInteractionEnabled = true
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let velocity = gestureRecognizer.velocity(in: topView)
        if(velocity.y < 0) {
            moveUP()
        } else {
            moveDown()
        }
    }
    
    func moveUP() {
        UIView.animate(withDuration: 0.8) { [weak self] in
            self?.topOfTopView.constant = 100
            self?.indicatorView.alpha = 0
            self?.topOfTitle.constant = 0
            self?.bgImageView.alpha = 0
            self?.lblTitle.alpha = 0
            self?.lblSubTitle.alpha = 0
            self?.view.layoutIfNeeded()
        } completion: {[weak self] (status) in
            self?.lblTitle.text = "Statement"
            self?.lblTitle.alpha = 1
        }
    }
    
    func moveDown(time:TimeInterval = 0.8) {
        UIView.animate(withDuration: time) { [weak self] in
            self?.topOfTopView.constant = 175
            self?.indicatorView.alpha = 1
            self?.topOfTitle.constant = 64
            self?.bgImageView.alpha = 1
            self?.lblSubTitle.alpha = 1
            self?.lblTitle.alpha = 0
            self?.view.layoutIfNeeded()
        } completion: {[weak self] (status) in
            self?.lblTitle.text = "Wallet"
            self?.lblTitle.alpha = 1
        }
    }
}

extension WalletViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWallet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WalletCell.reuseIdentifier, for: indexPath) as! WalletCell
        if indexPath.row % 2 == 0 {
            cell.statusIndicatorImageView.image = UIImage(named: "up")
            cell.lblPrice.textColor = .themeRedColor
        } else {
            cell.statusIndicatorImageView.image = UIImage(named: "down")
            cell.lblPrice.textColor = .themeLightColor
        }
        cell.btnViewMore.block_setAction {[weak self] (control) in
            let notification = OrderDetailViewController(nibName: "OrderDetailViewController", bundle: nil)
            notification.isBackButton = true
            self?.navigationController?.pushViewController(notification, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return arrHeight.contains(indexPath.row) ? 160 : 68
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrHeight.contains(indexPath.row) {
            arrHeight.remove(indexPath.row)
        } else {
            arrHeight.add(indexPath.row)
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: { _ in
            tableView.reloadData()
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 50 {
            moveUP()
        } else if scrollView.contentOffset.y < 50 {
            moveDown()
        }
    }
}
