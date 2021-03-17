//
//  OrderFilterView.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class OrderFilterView: UIView {
 
    @IBOutlet weak var btnAllOrders: UIButton!
    @IBOutlet weak var btnActiveOrders: UIButton!
    @IBOutlet weak var btnCompletedOrders: UIButton!
    @IBOutlet weak var btnCancelledOrders: UIButton!
    var btnSelected:((Int)->Void)?
    var selectedIndex:Int = 0
    
    func setupSelection() {
        if selectedIndex == 0 {
            btnAllOrders.isSelected = true
            btnActiveOrders.isSelected = false
            btnCompletedOrders.isSelected = false
            btnCancelledOrders.isSelected = false
            
        } else if selectedIndex == 1 {
            btnAllOrders.isSelected = false
            btnActiveOrders.isSelected = true
            btnCompletedOrders.isSelected = false
            btnCancelledOrders.isSelected = false
            
        } else if selectedIndex == 2 {
            btnAllOrders.isSelected = false
            btnActiveOrders.isSelected = false
            btnCompletedOrders.isSelected = true
            btnCancelledOrders.isSelected = false
            
        } else if selectedIndex == 3 {
            btnAllOrders.isSelected = false
            btnActiveOrders.isSelected = false
            btnCompletedOrders.isSelected = false
            btnCancelledOrders.isSelected = true
        }
    }
    
    @IBAction func btnFilterAction(_ sender: UIButton) {
        
        if sender == btnAllOrders {
            btnAllOrders.isSelected = true
            btnActiveOrders.isSelected = false
            btnCompletedOrders.isSelected = false
            btnCancelledOrders.isSelected = false
            guard let actionButton = btnSelected else { return }
            actionButton(0)
        } else if sender == btnActiveOrders {
            btnAllOrders.isSelected = false
            btnActiveOrders.isSelected = true
            btnCompletedOrders.isSelected = false
            btnCancelledOrders.isSelected = false
            guard let actionButton = btnSelected else { return }
            actionButton(1)
        } else if sender == btnCompletedOrders {
            btnAllOrders.isSelected = false
            btnActiveOrders.isSelected = false
            btnCompletedOrders.isSelected = true
            btnCancelledOrders.isSelected = false
            guard let actionButton = btnSelected else { return }
            actionButton(2)
        } else if sender == btnCancelledOrders {
            btnAllOrders.isSelected = false
            btnActiveOrders.isSelected = false
            btnCompletedOrders.isSelected = false
            btnCancelledOrders.isSelected = true
            guard let actionButton = btnSelected else { return }
            actionButton(3)
        }
        
    }
}
