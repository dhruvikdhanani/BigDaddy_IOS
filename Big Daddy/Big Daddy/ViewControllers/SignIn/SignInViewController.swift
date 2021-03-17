//
//  SignInViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var loginSegmentControl: UISegmentedControl!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    @IBOutlet weak var txtFourth: UITextField!
    
   
    
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var dict = typeAliasDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnForgotPassword.setHyperLink()
        let titleTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font:UIFont(name: "Montserrat-SemiBold", size: 15)!]
        let titleTextAttributeSelected = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font:UIFont(name: "Montserrat-SemiBold", size: 15)!]
        loginSegmentControl.setTitleTextAttributes(titleTextAttribute, for: .normal)
        loginSegmentControl.setTitleTextAttributes(titleTextAttributeSelected, for: .selected)
        btnSignUp.attributedTextOf("Sign Up")
        txtFirst.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtSecond.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: UIControl.Event.editingChanged)
        txtThird.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: UIControl.Event.editingChanged)
        txtFourth.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: UIControl.Event.editingChanged)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func btnForgotPasswordAction(_ sender: UIButton) {
        callForgotPassword()
    }
    
    @IBAction func switchSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mobileView.isHidden = false
            emailView.isHidden = true
        } else {
            mobileView.isHidden = true
            emailView.isHidden = false
        }
    }
    
    @IBAction func btnSignUpAction(_ sender: UIButton) {
        let signup = SignUpViewController.init(nibName: "SignUpViewController", bundle: nil)
        self.navigationController?.pushViewController(signup, animated: true)
    }
    
    @IBAction func btnSignInAction(_ sender: UIButton) {
      appDelegate().showDash()
//        if loginSegmentControl.selectedSegmentIndex == 0 {
//            verifyLoginWithOTP()
//        } else {
//            callLoginWithEmail()
//        }
    }
    
    @IBAction func btnResendAction(_ sender: UIButton) {
        callLoginWithOTP()
    }
    
    func verifyLoginWithOTP() {
        let otp = txtFirst.getText().trim() + txtSecond.getText().trim() + txtThird.getText().trim() + txtFourth.getText().trim()
        if txtMobileNumber.isEmpty() {
            showAlertWithTitle(message: "Please Enter Mobile Number", type: .WARNING)
            return
        }
        if !txtMobileNumber.getText().validateMobileNo() {
            showAlertWithTitle(message: "Please Enter Valid Mobile Number", type: .WARNING)
            return
        }
        if otp.count < 4 {
            showAlertWithTitle(message: "Please Enter OTP", type: .WARNING)
            return
        }
        var param = typeAliasDictionary()
        param["mobile"] = txtMobileNumber.getText().trim()
        param["for_what"] = "L"
        param["otp"] = otp
        param["smsid"] = dict.valuForKeyString("smsid")
        param["currentdatetime"] = dict.valuForKeyString("currentdatetime")
        
        callRestApi("customer/check-otp-for-login-mobile", methodType: .POST, parameters: param, contentType: .RAW) { [weak self] (dict) in
            if dict.valuForKeyBool("success") {
                SharedModel.setToken(dict.valuForKeyString("data"))
                showAlertWithTitle(message: dict.valuForKeyString("message"), type: .SUCCESS)
                self?.appDelegate().showDash()
            }
        }
    }
    
    
    
    func callLoginWithOTP() {
        if txtMobileNumber.isEmpty() {
            showAlertWithTitle(message: "Please Enter Mobile Number", type: .WARNING)
            return
        }
        if !txtMobileNumber.getText().validateMobileNo() {
            showAlertWithTitle(message: "Please Enter Valid Mobile Number", type: .WARNING)
            return
        }
        var param = typeAliasDictionary()
        param["mobile"] = txtMobileNumber.getText().trim()
        param["for_what"] = "L"
        callRestApi("customer/send-otp-for-login-mobile", methodType: .POST, parameters: param, contentType: .RAW) { [weak self] (dict) in
            if dict.valuForKeyBool("success") {
                self?.dict = dict.valuForKeyDic("data")
            }
        }
    }
    
    func callLoginWithEmail() {
        if txtEmail.isEmpty() {
            showAlertWithTitle(message: "Please Enter Email", type: .WARNING)
            return
        }
        if !txtEmail.getText().validateEmail() {
            showAlertWithTitle(message: "Please Enter Valid Email", type: .WARNING)
            return
        }
        if txtPassword.isEmpty() {
            showAlertWithTitle(message: "Please Enter Password", type: .WARNING)
            return
        }
        var param = typeAliasDictionary()
        param["email"] = txtEmail.getText().trim()
        param["password"] = txtPassword.getText().trim()
        callRestApi("customer/login-with-email", methodType: .POST, parameters: param, contentType: .RAW) { [weak self] (dict) in
            if dict.valuForKeyBool("success") {
                SharedModel.setToken(dict.valuForKeyString("data"))
                showAlertWithTitle(message: dict.valuForKeyString("message"), type: .SUCCESS)
                self?.appDelegate().showDash()
            }
        }
    }
    
    func callForgotPassword() {
        if txtEmail.isEmpty() {
            showAlertWithTitle(message: "Please Enter Email", type: .WARNING)
            return
        }
        if !txtEmail.getText().validateEmail() {
            showAlertWithTitle(message: "Please Enter Valid Email", type: .WARNING)
            return
        }
        
        var param = typeAliasDictionary()
        param["email"] = txtEmail.getText().trim()
        param["for_what"] = "F"
        callRestApi("customer/send-otp-for-forgot-password-email", methodType: .POST, parameters: param, contentType: .RAW) { [weak self] (dict) in
            if dict.valuForKeyBool("success") {
                self?.dict = dict.valuForKeyDic("data")
                let forgot = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
                forgot.dict = dict.valuForKeyDic("data")
                forgot.email = self!.txtEmail.getText().trim()
                self?.navigationController?.pushViewController(forgot, animated: true)
            }
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == txtMobileNumber {
            if txtMobileNumber.getText().validateMobileNo() {
                txtMobileNumber.resignFirstResponder()
//                callLoginWithOTP()
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
