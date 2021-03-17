//
//  PersonalDetailViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class PersonalDetailViewController: UIViewController {

    @IBOutlet weak var personalDetailSegmentControl: UISegmentedControl!
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var businessNameView: UIView!
    @IBOutlet weak var panNumberView: UIView!
    @IBOutlet weak var gstNumberView: UIView!
    @IBOutlet weak var transporterNameView: UIView!
    @IBOutlet weak var transporterIDView: UIView!
    @IBOutlet weak var gstExemptedView: UIView!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    @IBOutlet weak var txtTransporterID: UITextField!
    @IBOutlet weak var txtGSTNo: UITextField!
    @IBOutlet weak var txtPanNo: UITextField!
    @IBOutlet weak var txtTransporterName: UITextField!
    @IBOutlet weak var txtBusinessName: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font:UIFont(name: "Montserrat-SemiBold", size: 15)!]
        let titleTextAttributeSelected = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font:UIFont(name: "Montserrat-SemiBold", size: 15)!]
        personalDetailSegmentControl.setTitleTextAttributes(titleTextAttribute, for: .normal)
        personalDetailSegmentControl.setTitleTextAttributes(titleTextAttributeSelected, for: .selected)
        personalDetailSegmentControl.selectedSegmentIndex = 0
        userTypeSegmentedControlAction(personalDetailSegmentControl)
    }
    
    func signup() {
        if !txtMobileNumber.getText().validateMobileNo() || txtMobileNumber.getText().isEmpty {
            showAlertWithTitle(message: "Please Enter Valid Mobile Number", type: .WARNING)
            return
        }
        
        if !txtEmail.getText().validateEmail() ||  txtEmail.getText().isEmpty {
            showAlertWithTitle(message: "Please Enter Email Valid Address", type: .WARNING)
           return
        }
        
        var param = typeAliasDictionary()
        if personalDetailSegmentControl.selectedSegmentIndex == 0 {
            param["customer_type"] = "Transporter"
            param["gst_number"] = txtTransporterID.getText().trim()
            param["transporter_fullname"] = txtTransporterName.getText().trim()
        } else if personalDetailSegmentControl.selectedSegmentIndex == 1 {
            param["customer_type"] = "Business"
            if btnYes.isSelected {
                param["pan_no"] = txtPanNo.getText().trim()
                param["customer_gst_exempted_type"] = "1"
            } else {
                param["customer_gst_exempted_type"] = "0"
                param["gst_number"] = txtGSTNo.getText().trim()
            }
            param["transporter_fullname"] = txtBusinessName.getText().trim()
        } else if personalDetailSegmentControl.selectedSegmentIndex == 2 {
            param["customer_type"] = "Individual"
            param["gst_number"] = ""
            param["pan_no"] = txtPanNo.getText().trim()
            param["transporter_fullname"] = txtFullName.getText().trim()
        }
        param["mobile"] = txtMobileNumber.getText().trim()
        param["email"] = txtEmail.getText().trim()
        param["password"] = txtPassword.getText().trim()
        param["confirm_password"] = txtConfirmPassword.getText().trim()
        
        callRestApi("customer/signup-with-mobile", methodType: .POST, parameters: param, contentType: .RAW) { [weak self] (dict) in
            if dict.valuForKeyBool("success") {
                SharedModel.setToken(dict.valuForKeyString("data"))
                self?.appDelegate().showDash()
            }
        }
    }
    
    @IBAction func btnGSTExemptedAction(_ sender: UIButton) {
        if sender == btnYes {
            btnYes.isSelected = true
            btnNo.isSelected = false
            panNumberView.isHidden = false
            gstNumberView.isHidden = true
        } else {
            btnYes.isSelected = false
            btnNo.isSelected = true
            panNumberView.isHidden = true
            gstNumberView.isHidden = false
        }
    }
    
    @IBAction func userTypeSegmentedControlAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            transporterIDView.isHidden = false
            transporterNameView.isHidden = false
            fullNameView.isHidden = true
            businessNameView.isHidden = true
            panNumberView.isHidden = true
            gstNumberView.isHidden = true
            gstExemptedView.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            gstExemptedView.isHidden = false
            if btnYes.isSelected {
                panNumberView.isHidden = false
                gstNumberView.isHidden = true
            } else {
                panNumberView.isHidden = true
                gstNumberView.isHidden = false
            }
            businessNameView.isHidden = false
            transporterIDView.isHidden = true
            transporterNameView.isHidden = true
            fullNameView.isHidden = true
        } else if sender.selectedSegmentIndex == 2 {
            panNumberView.isHidden = false
            fullNameView.isHidden = false
            gstNumberView.isHidden = true
            transporterNameView.isHidden = true
            transporterIDView.isHidden = true
            gstExemptedView.isHidden = true
            businessNameView.isHidden = true
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
//        signup()
      appDelegate().showDash()
    }
    
}
