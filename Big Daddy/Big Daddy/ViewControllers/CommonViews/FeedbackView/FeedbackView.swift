//
//  FeedbackView.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class FeedbackView: UIView,UITextViewDelegate {
 
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnClose.dropShadow()
        textView.delegate = self
        textView.textColor = UIColor.lightGray
    }
    
    @IBAction func btnCloseAction(_ sender: UIButton) {
        self.parentViewController?.dismissMaskView()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What did you like or dislike?"
            textView.textColor = UIColor.lightGray
        }
    }
}
