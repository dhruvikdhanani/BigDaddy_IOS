//
//  ManageProfileViewController.swift
//  Big Daddy
//
//  Created by Technomads on 19/02/21.
//

import UIKit

class ManageProfileViewController: UIViewController {

    @IBOutlet weak var topOfMainHeaderLabel: NSLayoutConstraint!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var topOfScrollView: NSLayoutConstraint!
    @IBOutlet weak var addressTableView: UITableView!
    var arrAddress:[typeAliasDictionary] = [typeAliasDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTableView.register(UINib(nibName: AddressCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: AddressCell.reuseIdentifier)
        addressTableView.tableFooterView = UIView(frame: .zero)
        roundView.dropShadowed(cornerRadius: 24, corners: [.topLeft,.topRight], borderColor: .clear, borderWidth: 0, shadowColor: .clear)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        arrAddress = [typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary(), typeAliasDictionary()]
        addressTableView.reloadData()
        heightOfTableView.constant = (CGFloat(arrAddress.count)*70.0)+50.0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnEditAction(_ sender: UIButton) {
        moveUP()
    }
    
    @IBAction func btnNotificationAction(_ sender: UIButton) {
        let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
        notification.isBackButton = true
        self.navigationController?.pushViewController(notification, animated: true)
    }
    
    func moveUP() {
        UIView.animate(withDuration: 0.8) { [weak self] in
            self?.topOfScrollView.constant = 08
            self?.indicatorView.alpha = 0
            self?.topOfMainHeaderLabel.constant = 0
            self?.bgImageView.alpha = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    func moveDown(time:TimeInterval = 0.8) {
        UIView.animate(withDuration: time) { [weak self] in
            self?.topOfScrollView.constant = 150
            self?.indicatorView.alpha = 1
            self?.topOfMainHeaderLabel.constant = 64
            self?.bgImageView.alpha = 1
            self?.view.layoutIfNeeded()
        }
    }
}

extension ManageProfileViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseIdentifier, for: indexPath) as! AddressCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view:AddressFooterView = UIView.fromNib()
        view.btnAddNewAddress.block_setAction { (control) in
            
        }
        return view
    }
    
}


extension ManageProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != addressTableView {
            if scrollView.contentOffset.y > 0 {
                moveUP()
            } else if scrollView.contentOffset.y < 50 {
                moveDown()
            }
        }
    }
}
