//
//  ForgotPasswordViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var txtFirstForgot: UITextField!
    @IBOutlet weak var txtSecondForgot: UITextField!
    @IBOutlet weak var txtThirdForgot: UITextField!
    @IBOutlet weak var txtFourthForgot: UITextField!
    var dict:typeAliasDictionary = typeAliasDictionary()
    var email:String = ""
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnResend.setHyperLink()
        txtFirstForgot.addTarget(self, action: #selector(textFieldDidChangeForgot(textField:)), for: UIControl.Event.editingChanged)
        txtSecondForgot.addTarget(self, action: #selector(textFieldDidChangeForgot(textField: )), for: UIControl.Event.editingChanged)
        txtThirdForgot.addTarget(self, action: #selector(textFieldDidChangeForgot(textField: )), for: UIControl.Event.editingChanged)
        txtFourthForgot.addTarget(self, action: #selector(textFieldDidChangeForgot(textField: )), for: UIControl.Event.editingChanged)
    }

    @objc func textFieldDidChangeForgot(textField: UITextField){
        
        let text = textField.text
        
        if text!.utf16.count == 1 {
            switch textField{
            case txtFirstForgot:
                txtFirstForgot.dropShadow()
                txtSecondForgot.becomeFirstResponder()
            case txtSecondForgot:
                txtSecondForgot.dropShadow()
                txtThirdForgot.becomeFirstResponder()
            case txtThirdForgot:
                txtThirdForgot.dropShadow()
                txtFourthForgot.becomeFirstResponder()
            case txtFourthForgot:
                txtFourthForgot.dropShadow()
                txtFourthForgot.resignFirstResponder()
            default:
                break
            }
        } else if text!.utf16.count > 1 {
            textField.text = ""
        } else {
            if let char = text!.cString(using: String.Encoding.utf8) {
                if (strcmp(char, "\\b") == -92) {
                    switch textField{
                    case txtFirstForgot:
                        txtFirstForgot.dropShadow(color:.clear)
                        txtFirstForgot.becomeFirstResponder()
                    case txtSecondForgot:
                        txtSecondForgot.dropShadow(color:.clear)
                        txtFirstForgot.becomeFirstResponder()
                    case txtThirdForgot:
                        txtThirdForgot.dropShadow(color:.clear)
                        txtSecondForgot.becomeFirstResponder()
                    case txtFourthForgot:
                        txtFourthForgot.dropShadow(color:.clear)
                        txtThirdForgot.becomeFirstResponder()
                    default:
                        break
                    }
                }
            }
        }
    }

    @IBAction func btnChangePassword(_ sender: UIButton) {
        verifyForgotWithOTP()
    }
    
    @IBAction func btnResendAction(_ sender: UIButton) {
        callForgotPassword()
    }
     
    func verifyForgotWithOTP() {
        let otp = txtFirstForgot.getText().trim() + txtSecondForgot.getText().trim() + txtThirdForgot.getText().trim() + txtFourthForgot.getText().trim()
        
        if otp.count < 4 {
            showAlertWithTitle(message: "Please Enter OTP", type: .WARNING)
            return
        }
        if txtPassword.isEmpty() {
            showAlertWithTitle(message: "Please Enter Password", type: .WARNING)
            return
        }
        if txtConfirmPassword.isEmpty() {
            showAlertWithTitle(message: "Please Enter Confirm Password", type: .WARNING)
            return
        }
        var param = typeAliasDictionary()
        param["email"] = email
        param["for_what"] = "F"
        param["otp"] = otp
        param["smsid"] = dict.valuForKeyString("smsid")
        param["currentdatetime"] = dict.valuForKeyString("currentdatetime")
        param["password"] = txtPassword.getText().trim()
        param["confirm_password"] = txtConfirmPassword.getText().trim()
        callRestApi("customer/check-otp-for-forgot-password-email", methodType: .POST, parameters: param, contentType: .RAW) { [weak self] (dict) in
            if dict.valuForKeyBool("success") {
                showAlertWithTitle(message: dict.valuForKeyString("message"), type: .SUCCESS)
                self?.appDelegate().showLogin()
            }
        }
    }
    
    func callForgotPassword() {
        
        var param = typeAliasDictionary()
        param["email"] = email
        param["for_what"] = "F"
        callRestApi("customer/send-otp-for-forgot-password-email", methodType: .POST, parameters: param, contentType: .RAW) { [weak self] (dict) in
            if dict.valuForKeyBool("success") {
                self?.dict = dict.valuForKeyDic("data")
            }
        }
    }
}
