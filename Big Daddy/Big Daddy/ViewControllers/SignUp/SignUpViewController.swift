//
//  SignUpViewController.swift
//  Big Daddy
//
//  Created by Technomads on 15/02/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    @IBOutlet weak var txtFourth: UITextField!
    
    var dict:typeAliasDictionary = typeAliasDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignIn.attributedTextOf("Sign In")
        btnResend.setHyperLink()
        txtFirst.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtSecond.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: UIControl.Event.editingChanged)
        txtThird.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: UIControl.Event.editingChanged)
        txtFourth.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: UIControl.Event.editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func btnSignInAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCreateAccountAction(_ sender: UIButton) {
        verifyOTP()
    }
    
    @IBAction func btnResendAction(_ sender: UIButton) {
        if txtMobileNumber.isEmpty() {
            showAlertWithTitle(message: "Please Enter Mobile Number", type: .WARNING)
            return
        }
        if !txtMobileNumber.getText().validateMobileNo() {
            showAlertWithTitle(message: "Please Enter Valid Mobile Number", type: .WARNING)
            return
        }
        sendOTP()
    }
    
    func sendOTP() {
        var param = typeAliasDictionary()
        param["mobile"] = txtMobileNumber.getText().trim()
        param["for_what"] = "R"
        callRestApi("customer/send-otp-for-signup-mobile", methodType: .POST, parameters: param, contentType: .RAW) { [weak self] (dict) in
            self?.dict = dict.valuForKeyDic("data")
        }
    }
    
    func verifyOTP() {
        let otp = (txtFirst.getText().trim() + txtSecond.getText().trim() + txtThird.getText().trim() + txtFourth.getText().trim())
        if otp.count < 4 {
            showAlertWithTitle(message: "Please Enter OTP", type: .WARNING)
            return
        }
        var param = typeAliasDictionary()
        param["mobile"] = txtMobileNumber.getText().trim()
        param["for_what"] = "R"
        param["otp"] = otp
        param["smsid"] = dict.valuForKeyString("smsid")
        param["currentdatetime"] = dict.valuForKeyString("currentdatetime")
        callRestApi("customer/check-otp-for-signup-mobile", methodType: .POST, parameters: param, contentType: .RAW) { [weak self] (dict) in
            if dict.valuForKeyBool("success") {
                let personalDetail = PersonalDetailViewController.init(nibName: "PersonalDetailViewController", bundle: nil)
                self?.navigationController?.pushViewController(personalDetail, animated: true)
            }
        }
    }
    
}
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == txtMobileNumber {
            if txtMobileNumber.getText().validateMobileNo() {
                txtMobileNumber.resignFirstResponder()
                sendOTP()
            } else if txtMobileNumber.getText().count >= 10 {
                showAlertWithTitle(message: "Please Enter Valid Mobile Number", type: .WARNING)
            }
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        if text!.utf16.count == 1 {
            switch textField{
            case txtFirst:
                txtFirst.dropShadow()
                txtSecond.becomeFirstResponder()
            case txtSecond:
                txtSecond.dropShadow()
                txtThird.becomeFirstResponder()
            case txtThird:
                txtThird.dropShadow()
                txtFourth.becomeFirstResponder()
            case txtFourth:
                txtFourth.dropShadow()
                txtFourth.resignFirstResponder()
            default:
                break
            }
        } else if text!.utf16.count > 1 {
            textField.text = ""
        } else {
            if let char = text!.cString(using: String.Encoding.utf8) {
                if (strcmp(char, "\\b") == -92) {
                    switch textField{
                    case txtFirst:
                        txtFirst.dropShadow(color:.clear)
                        txtFirst.becomeFirstResponder()
                    case txtSecond:
                        txtSecond.dropShadow(color:.clear)
                        txtFirst.becomeFirstResponder()
                    case txtThird:
                        txtThird.dropShadow(color:.clear)
                        txtSecond.becomeFirstResponder()
                    case txtFourth:
                        txtFourth.dropShadow(color:.clear)
                        txtThird.becomeFirstResponder()
                    default:
                        break
                    }
                }
            }
        }
    }
}
