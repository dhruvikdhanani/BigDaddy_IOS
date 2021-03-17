//
//  SideMenuViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var sideMenuTableView: UITableView!
    var listData:[typeAliasDictionary] = [typeAliasDictionary]()
    var selectedIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuTableView.register(UINib(nibName: SideMenuCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SideMenuCell.reuseIdentifier)
        sideMenuTableView.tableFooterView = UIView(frame: .zero)
       let dict1 = ["title":"Home","image":"home"]
       let dict2 = ["title":"New Order","image":"new_order"]
       let dict3 = ["title":"Order List","image":"order_list"]
       let dict4 = ["title":"Track Order","image":"track_order"]
       let dict5 = ["title":"Wallet","image":"wallet"]
       let dict6 = ["title":"Manage Profile","image":"profile"]
       let dict7 = ["title":"Settings","image":"settings"]
       let dict8 = ["title":"Logout","image":"logout"]
        listData = [
            dict1,
            dict2,
            dict3,
            dict4,
            dict5,
            dict6,
            dict7,
            dict8
        ]
        secondView.dropShadowed(cornerRadius: 16, corners: [.topLeft,.bottomLeft], borderColor: .clear, borderWidth: 0, shadowColor: .lightGray)   
    }
    
    
    func handleTouch(at index: Int) {
        selectedIndex = index
        switch index {
        case 0:
            let contentViewController = AppNavigationViewController(rootViewController: OrderListViewController())
            sideMenuViewController?.setContentViewController(contentViewController, animated: true)
        case 1:
            let contentViewController = AppNavigationViewController(rootViewController: NewOrderViewController())
            sideMenuViewController?.setContentViewController(contentViewController, animated: true)
        case 2:
            let contentViewController = AppNavigationViewController(rootViewController: OrderListViewController())
            sideMenuViewController?.setContentViewController(contentViewController, animated: true)
        case 3:
            let contentViewController = AppNavigationViewController(rootViewController: TrackOrderViewController())
            sideMenuViewController?.setContentViewController(contentViewController, animated: true)
        case 4:
            let contentViewController = AppNavigationViewController(rootViewController: WalletViewController())
            sideMenuViewController?.setContentViewController(contentViewController, animated: true)
        case 5:
            let contentViewController = AppNavigationViewController(rootViewController: ManageProfileViewController())
            sideMenuViewController?.setContentViewController(contentViewController, animated: true)
        case 6:
            let contentViewController = AppNavigationViewController(rootViewController: SettingsViewController())
            sideMenuViewController?.setContentViewController(contentViewController, animated: true)
        default:
            appDelegate().showLogin()
        }
        sideMenuViewController?.hideMenuViewController()
    }
}

extension SideMenuViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.reuseIdentifier, for: indexPath) as! SideMenuCell
        cell.lblTitle.text = listData[indexPath.row].valuForKeyString("title")
        cell.symbolImageView.image = UIImage(named: listData[indexPath.row].valuForKeyString("image"))
        if selectedIndex == indexPath.row {
            cell.lblTitle.textColor = .themeColor
            cell.symbolImageView.tintColor = .themeColor
        } else {
            cell.lblTitle.textColor = .black
            cell.symbolImageView.tintColor = .black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleTouch(at: indexPath.row)
        tableView.reloadData()
    }
}
