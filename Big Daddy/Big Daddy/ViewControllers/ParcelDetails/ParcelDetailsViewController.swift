//
//  ParcelDetailsViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class ParcelDetailsViewController: UIViewController {

    @IBOutlet weak var parcelDetailTableView: UITableView!
    var arrLR:[typeAliasDictionary] = [typeAliasDictionary]()
    var arrParcel:[typeAliasDictionary] = [typeAliasDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle("Parcel Details")
        setLeftBarButton()
        setRightBarButton("notification") { [weak self](str) in
            let notification = NotificationViewController(nibName: "NotificationViewController", bundle: nil)
            notification.isBackButton = true
            self?.navigationController?.pushViewController(notification, animated: true)
        }
        parcelDetailTableView.register(UINib(nibName: FileCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: FileCell.reuseIdentifier)
        parcelDetailTableView.register(UINib(nibName: ParcelDetailCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ParcelDetailCell.reuseIdentifier)
        parcelDetailTableView.tableFooterView = UIView(frame: .zero)
        arrLR = [typeAliasDictionary(),typeAliasDictionary()]
        arrParcel = [typeAliasDictionary()]
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
        let address = AddressViewController(nibName: "AddressViewController", bundle: nil)
        address.isBackButton = true
        address.isPickAddress = true
        self.navigationController?.pushViewController(address, animated: true)
    }
}

extension ParcelDetailsViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return arrLR.count
        } else {
            return arrParcel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FileCell.reuseIdentifier, for: indexPath) as! FileCell
            cell.btnClose.backgroundColor = .clear
            cell.btnClose.tintColor = .black
            if indexPath.row % 2 == 0 {
                cell.fileTypeImageView.image = UIImage(named: "upload_excel")
            } else {
                cell.fileTypeImageView.image = UIImage(named: "upload_image")
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ParcelDetailCell.reuseIdentifier, for: indexPath) as! ParcelDetailCell
            cell.btnDelete.block_setAction { [weak self](control) in
                self?.arrParcel.remove(at: indexPath.row)
                    tableView.reloadData()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 40
        } else {
            return 250
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view:ParcelHeaderView = UIView.fromNib()
            return view
        } else {
            let view = UIView()
                view.backgroundColor = .lightText
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 70
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let view:ParcelFooterView = UIView.fromNib()
            view.btnAddMore.block_setAction { [weak self](control) in
                self?.arrParcel.append(typeAliasDictionary())
                tableView.reloadData()
            }
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 120
        }
    }
}
