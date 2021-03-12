//
//  OrderDetailViewController.swift
//  Big Daddy
//
//  Created by Technomads on 18/02/21.
//

import UIKit

class OrderDetailViewController: UIViewController {
    
    @IBOutlet weak var btnExcel: UIButton!
    @IBOutlet weak var pickupImageView: UIImageView!
    @IBOutlet weak var deliveryImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftBarButton()
        self.view.viewWithTag(100)?.dropShadowed()
        btnExcel.dropShadowed()
        pickupImageView.dropShadowed()
        deliveryImageView.dropShadowed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}
