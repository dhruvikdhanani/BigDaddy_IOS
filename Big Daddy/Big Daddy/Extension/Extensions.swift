// NOTE: You need to add `CommonParameter.swift` for typeAliasDictionary and typeAliasStringDictionary

import Foundation
import UIKit


fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

public enum Gravity: Int {
    case Top = 0
    case Center = 1
    case Bottom = 2
    case Left = 3
    case Right = 4
}

extension UIApplication {
    var keyWindowInConnectedScenes: UIWindow?{
        return windows.first(where: {$0.isKeyWindow})
    }
}

extension UIDevice {

    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
           return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 > 20
        }
        return false
   }
}

func appDelegateObject() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

extension UIViewController {
    
     
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //THIS IS RETUREN APP DELEGARE
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    /// get parent view controller from any where
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    
    /// Showing popup on the screen with gravity (LOL!! `Gravity` IS enum please check before use) see `dismissMaskView` for remove from view
    ///
    /// - Parameters:
    ///   - popupView: your view what you want to show as popup
    ///   - gravity: See Gravity line no 34
    
    func showPopUp(popupView:UIView, gravity:Gravity) {
        showPopUp(popupView: popupView, gravity:gravity,isBackClickDismiss:true)
    }
    
    func showPopUp(popupView:UIView, gravity:Gravity,isBackClickDismiss:Bool,Istag:Int? = 666) {
        if (self.view.viewWithTag(Istag!)) != nil {
            return  // already setted..
        } else {
            UIApplication.shared.beginIgnoringInteractionEvents()
            let maskView = UIView()
            maskView.tag = Istag!
            maskView.frame = UIScreen.main.bounds
            maskView.backgroundColor = UIColor.init(white: 0, alpha: 0.0)
            popupView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
            popupView.isMultipleTouchEnabled = false
            
            switch gravity{
            
            case .Top:
                do{
                    popupView.setY(y: -popupView.frame.height)
                }
            case .Center:do{   popupView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
            }
            case .Bottom:
                do{
                    popupView.tag = 1920123
                    popupView.setY(y: screenHeight)
                }
            case .Left:
                popupView.setX(x: -screenWidth)
                popupView.tag = 1920123
            case .Right: do {
                popupView.setX(x: screenWidth * 0.65)
                popupView.setY(y: 0)
                maskView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
                popupView.tag = 1920123
            }
            
            }
            
            if isBackClickDismiss{
                let TapButton : UIButton = UIButton.init(frame: UIScreen.main.bounds)
                maskView.addSubview(TapButton)
                if gravity == .Left || gravity == .Right {
                    TapButton.addTarget(self, action: #selector(dismissMaskViewLeftAnimation), for: .touchUpInside)
                }else if gravity == .Bottom {
                    TapButton.addTarget(self, action: #selector(dismissMaskViewBottomAnimation), for: .touchUpInside)
                } else {
                    TapButton.addTarget(self, action: #selector(dismissMaskView), for: .touchUpInside)
                }
            }
            maskView.addSubview(popupView)
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.view.addSubview(maskView)
            }
            
            if gravity == .Left{
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                    popupView.setX(x: 0)
                    maskView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
                })
                { (finished) in
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            } else if gravity == .Right {
                
                UIView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    popupView.setX(x: screenWidth * 0.65)
                    maskView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
                })
                { (finished) in
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            } else if gravity == .Bottom {
                UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseIn],
                               animations: {
                                popupView.center.y -= popupView.bounds.height
                                popupView.layoutIfNeeded()
                                maskView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
                               }) { (finished) in
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            } else if gravity == .Top {
                UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn],
                               animations: {
                                let topPadding = appDelegateObject().window?.safeAreaInsets.top ?? 0
                                popupView.setY(y: 0+topPadding)
                                maskView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
                               }) { (finished) in
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            } else {
                maskView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            
        }
        
    }
    
    /// dismiss method to popup view
    @objc func dismissMaskView()
    {
        if var topController = UIApplication.shared.keyWindowInConnectedScenes?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            if let theMask = topController.view.viewWithTag(666) {
                theMask.removeFromSuperview()
            }
        }
    }
    
    @objc func dismissMaskViewLeftAnimation()
    {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            if let theMask = topController.view.viewWithTag(666) {
                
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                    theMask.viewWithTag(1920123)?.setX(x: -screenWidth)
                    theMask.backgroundColor = UIColor.init(white: 0, alpha: 0.0)
                })
                { (finished) in
                    theMask.removeFromSuperview()
                }
                
            }
        }
    }
    
    @objc func dismissMaskViewBottomAnimation()
    {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            if let theMask = topController.view.viewWithTag(666) {
                
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                    theMask.viewWithTag(1920123)?.setY(y: screenHeight)
                    theMask.backgroundColor = UIColor.init(white: 0, alpha: 0.0)
                })
                { (finished) in
                    theMask.removeFromSuperview()
                }
                
            }
        }
    }
    
}

extension UITextView {
    
    
    open override func awakeFromNib() {
        //        self.autocapitalizationType = UITextAutocapitalizationType.none;
        //        self.autocorrectionType = UITextAutocorrectionType.no;
        //
        //        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        //
        //        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(UITextView.viewClick))
        //        view.addGestureRecognizer(tapGesture)
        //        view.isUserInteractionEnabled = true
        //        view.isMultipleTouchEnabled = true
        //
        //        let toolbar = UIToolbar.init()
        //        toolbar.sizeToFit()
        //        let barFlexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        //
        //        let barBtnDone = UIBarButtonItem.init(image: #imageLiteral(resourceName: "icn_keyboard"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnBarDoneAction))
        //        barBtnDone.tintColor = UIColor.black
        //        toolbar.barTintColor = UIColor.lightGray
        //        toolbar.tintColor = UIColor.black
        //        toolbar.items = [barFlexible,barBtnDone]
        //        toolbar.alpha = 0.9
        
        //        self.inputAccessoryView = toolbar
    }
    
    @objc func viewClick() { self.becomeFirstResponder(); }
    @objc func btnBarDoneAction() { self.resignFirstResponder() }
    
} //copy this code

extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        //        self.autocapitalizationType = UITextAutocapitalizationType.none;
        //        self.autocorrectionType = UITextAutocorrectionType.no;
        //
        //        let toolbar = UIToolbar.init()
        //        toolbar.sizeToFit()
        //      let barFlexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        //      let barBtnDone = UIBarButtonItem.init(image: #imageLiteral(resourceName: "icn_menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(btnBarDoneAction))
        //        barBtnDone.tintColor = UIColor.black
        //        toolbar.barTintColor = UIColor.lightGray
        //        toolbar.tintColor = UIColor.black
        //        toolbar.items = [barFlexible,barBtnDone]
        //        toolbar.alpha = 0.8
        //        self.inputAccessoryView = toolbar
    }
    
    
    /// use this method while you need text from text field as there never crash and get "" always string
    ///
    /// - Returns: <#return value description#>
    func getText()-> String{
        if (self.text?.count)! > 0{
            return self.text!
        }else{
            return ""
        }
    }
    
    
    /// For cheking is user endet any value or not
    ///
    /// - Returns: return value description
    func isEmpty()-> Bool{
        if (self.text?.count)! > 0{
            return false
        }else{
            return true
        }
    }
    
    func viewClick() { self.becomeFirstResponder(); }
    
    @objc func btnBarDoneAction() { self.resignFirstResponder() }
    
    
    /// this method to set right side image view when you need to set also check parameters
    ///
    /// - Parameters:
    ///   - width: pass width of image you want
    ///   - image: pass image (NOTE: you need to pass UIImage)
    func setRightImageView(_ width: CGFloat, image: UIImage) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width + 16, height: self.frame.height))
        let imageView: UIImageView = UIImageView().createImageView(CGRect(x: 8, y: 0, width: width, height: width), image: image, contentMode: .scaleAspectFit)
        view.addSubview(imageView)
        imageView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        self.rightViewMode = UITextField.ViewMode.always;
        self.rightView = view;
    }
    
    /// this method to set right side image view when you need to set also check parameters
    ///
    /// - Parameters:
    ///   - width: pass width of image button you want
    func setPasswordVisibility(_ onChange: @escaping ((Bool)->Void)) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50 , height: self.frame.height))
        let btn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn.block_setAction { (contrl) in
            btn.isSelected = !btn.isSelected
            onChange(btn.isSelected)
        }
        btn.setImage(UIImage(named: "hidden"), for: .normal)
        btn.setImage(UIImage(named: "visibility"), for: .selected)
        view.addSubview(btn)
        btn.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        self.rightViewMode = UITextField.ViewMode.always;
        self.rightView = view;
    }
    
    
    /// to make space distance to right side
    ///
    /// - Parameter width: pass width what you want right side clean
    func setRightClearView(_ width: CGFloat) {
        let view = UIView(frame: CGRect(x: 0 , y: 0, width: width, height: self.frame.height))
        view.backgroundColor = UIColor.clear
        self.rightViewMode = UITextField.ViewMode.always;
        self.rightView = view;
    }
    
    
    /// to make space distance on left side
    ///
    /// - Parameter width:  pass width what you want left side clean
    func setLeftClearView(_ width: CGFloat) {
        let view = UIView(frame: CGRect(x: 0 , y: 0, width: width, height: self.frame.height))
        view.backgroundColor = UIColor.clear
        self.leftViewMode = UITextField.ViewMode.always;
        self.leftView = view;
    }
    
    
    /// this method to set left side image view when you need to set also check parameters
    ///
    /// - Parameters:
    ///   - width: pass width of image you want
    ///   - image: pass image (NOTE: you need to pass UIImage)
    func setLeftImageView(_ width: CGFloat, image: UIImage) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width + 16, height: self.frame.height))
        let imageView: UIImageView = UIImageView().createImageView(CGRect(x: 8, y: 0, width: width, height: width), image: image, contentMode: .scaleAspectFit)
        
        view.addSubview(imageView)
        imageView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        self.leftViewMode = UITextField.ViewMode.always;
        self.leftView = view;
    }
    
    
}

extension UIButton {
    
    func hasImage(named imageName: String, for state: UIControl.State) -> Bool {
        guard let buttonImage = image(for: state), let namedImage = UIImage(named: imageName) else {
            return false
        }
        
        return buttonImage.pngData() == namedImage.pngData()
    }
    
    /// when ever you want button with underline just call this function
    func setHyperLink() {
        let text: String = self.currentTitle!
        let dictAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: self.titleLabel?.font as AnyObject, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue as AnyObject, NSAttributedString.Key.foregroundColor:(self.titleLabel?.textColor)!]
        self.titleLabel?.attributedText = NSAttributedString(string: text, attributes: dictAttribute)
    }
    
    func attributedTextOf(_ text:String) {
        let title: String = self.currentTitle!
        self.titleLabel?.lineBreakMode =  NSLineBreakMode.byWordWrapping
        let compalsorySign = NSMutableAttributedString(string: title)
        compalsorySign.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.themeColor, range: NSRange(location: title.distance(from: title.startIndex, to: title.range(of: text)!.lowerBound), length: text.count))
        compalsorySign.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: "Montserrat-Medium", size: 15)!, range: NSRange(location: title.distance(from: title.startIndex, to: title.range(of: text)!.lowerBound), length: text.count))
        self.setAttributedTitle(compalsorySign, for: .normal)
    }
    
    /// when ever you want multiline text in button just call this
    func setMultiLineText(_ line:Int?=0) {
        self.titleLabel?.numberOfLines = line!
        self.titleLabel?.textAlignment = NSTextAlignment.left
        self.titleLabel?.minimumScaleFactor = 0.3
    }
    
}

extension UIImage {
    
    func hasImage(named imageName: String) -> Bool {
        guard let namedImage = UIImage(named: imageName) else {
            return false
        }
        return self.pngData() == namedImage.pngData()
    }
    /// retun image with resize with %
    ///
    /// - Parameter percentage: pass %
    /// - Returns: return reduce UIImage
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    
    /// when you want a image with color overlay use me i will retun with given color
    ///
    /// - Parameter color: pass UIColor what you want as overlay
    /// - Returns: return UIImage with color overlay
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        color.setFill()
        self.draw(in: rect)
        
        context.setBlendMode(.sourceIn)
        context.fill(rect)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    
    /// when you need color from image call me i will retun color of that point
    ///
    /// - Parameters:
    ///   - location: pass location point from where you want color
    ///   - size: give image size so i find exect what you want
    /// - Returns: return color of that point
    func getPixelColor(atLocation location: CGPoint, withFrameSize size: CGSize) -> UIColor {
        let x: CGFloat = (self.size.width) * location.x / size.width
        let y: CGFloat = (self.size.height) * location.y / size.height
        
        let pixelPoint: CGPoint = CGPoint(x: x, y: y)
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelIndex: Int = ((Int(self.size.width) * Int(pixelPoint.y)) + Int(pixelPoint.x)) * 4
        
        let r = CGFloat(data[pixelIndex]) / CGFloat(255.0)
        let g = CGFloat(data[pixelIndex+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelIndex+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelIndex+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    
    /// color overlay with given color
    ///
    /// - Parameter color: UIColor for over lay
    /// - Returns: return value UIimage with color overlay
    func colorized(color : UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setBlendMode(.multiply)
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.draw(self.cgImage!, in: rect)
            context.clip(to: rect, mask: self.cgImage!)
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        
        let colorizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return colorizedImage!
        
    }
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Usage
    /*if let imageData = image.jpeg(.lowest) {
     print(imageData.count)
     } */
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension UILabel {
    
    func attributedCompalsorySign() {
        var str = self.text!
        if !(str.contains("*")) {
            str = str + " *"
        }
        let compalsorySign = NSMutableAttributedString(string: str)
        compalsorySign.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: str.distance(from: str.startIndex, to: str.range(of: "*")!.lowerBound), length: 1))
        self.attributedText = compalsorySign
    }
    
    func attributedTextOf(_ text:String, color:UIColor? = UIColor.themeFontColor, font:UIFont? = nil) {
        let compalsorySign = NSMutableAttributedString(string: self.text!)
        var fontSize:UIFont
        if let f = font {
            fontSize = f
        } else {
            fontSize = self.font!
        }
        compalsorySign.addAttribute(NSAttributedString.Key.foregroundColor, value: color!, range: NSRange(location: self.text!.distance(from: self.text!.startIndex, to: self.text!.range(of: text)!.lowerBound), length: text.count))
        compalsorySign.addAttribute(NSAttributedString.Key.font, value: fontSize, range: NSRange(location: self.text!.distance(from: self.text!.startIndex, to: self.text!.range(of: text)!.lowerBound), length: text.count))
        self.attributedText = compalsorySign
    }
    
    
    /// calculation of hight of lable to use make height dynamic
    ///
    /// - Returns: retun final hight of lable
    func estimatedHeightOfLabel() -> CGFloat {
        let size = CGSize(width: self.frame.width - 16, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let rectangleHeight = String(self.text!).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        return rectangleHeight + 5
    }
    
    
    /// calculation of hight of lable to use make height dynamic when you have fix width
    ///
    /// - Parameters:
    ///   - textWidth: pass width what you want
    ///   - textFont: pass font of text
    /// - Returns: return hight of that text
    func textHeight(_ textWidth: CGFloat, textFont: UIFont) -> CGFloat {
        let textRect: CGRect = String(self.text!).boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        let textSize: CGSize = textRect.size;
        return self.text! == "" ? 0.0 : textSize.height
    }
    
    /// give string witdh
    ///
    /// - Parameters:
    ///   - textHeight: give height what you need in width
    ///   - textFont: pass font
    /// - Returns: return width as per height and font
    func textWidth(_ textHeight: CGFloat, textFont: UIFont) -> CGFloat {
        let textRect: CGRect = String(self.text!).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: textHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        let textSize: CGSize = textRect.size
        return ceil(textSize.width)
    }
    
    /// when ever you want button with underline just call this function
    func setHyperLink() {
        let text: String = self.text!
        let dictAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: self.font as AnyObject, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue as AnyObject, NSAttributedString.Key.foregroundColor:(self.textColor)!]
        self.attributedText = NSAttributedString(string: text, attributes: dictAttribute)
    }
}

extension UIImageView {
    
    func hasImage(named imageName: String) -> Bool {
        guard let buttonImage = self.image, let namedImage = UIImage(named: imageName) else {
            return false
        }
        return buttonImage.pngData() == namedImage.pngData()
    }
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    /// this is normal function to create UIImageView in one line
    ///
    /// - Parameters:
    ///   - frame: pass UIImageView frame
    ///   - image: pass UIImage what you need in that image view
    ///   - contentMode: pass content mode
    /// - Returns: UIImageView with give modes
    func createImageView(_ frame: CGRect, image: UIImage, contentMode: UIView.ContentMode) -> UIImageView
    {
        let imageView: UIImageView = UIImageView.init(frame: frame);
        imageView.image = image;
        imageView.contentMode = contentMode;
        return imageView;
    }
    
    
    /// set imageview tint color
    ///
    /// - Parameter color: set color what you want on overlay
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}


extension Date {
    
    func toString(withFormat format: String = "dd-MM-yyyy HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "en_US")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String {
    
    func verifyUrl() -> Bool {
        if let url = NSURL(string: self) {
            return UIApplication.shared.canOpenURL(url as URL)
        } 
        return false
    }
    
    func convertStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        return  dateFormatter.date(from:self)!.toString()
    }
    
    func convertString() -> String {
        let data = self.data(using: String.Encoding.ascii, allowLossyConversion: true)
        return NSString(data: data!, encoding: String.Encoding.ascii.rawValue)! as String
    }
    
    func getLowerSplit(splitBy: String) -> String {
        if let range = self.range(of: splitBy) {
            return String(self[self.startIndex..<range.lowerBound])
        } else {
            return self
        }
    }
    
    func getUpperSplit(splitBy: String) -> String {
        if let range = self.range(of: splitBy) {
            return String(self[range.upperBound...])
        } else {
            return self
        }
    }
    
    func splitBeforeIndex(_ index:Int) -> String {
        let subIndex = self.index(self.startIndex, offsetBy: index)
        return String(self.prefix(upTo: subIndex))
    }
    
    func isEmailValid() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    /// replace text in string
    ///
    /// - Parameters:
    ///   - string: orignal string
    ///   - withString: replace string
    /// - Returns: give final string
    mutating func replace(_ string: String, withString: String) -> String {
        return self.replacingOccurrences(of: string, with: withString)
    }
    
    
    /// replace blank space with given string
    ///
    /// - Parameter withString: pass replaeing string
    /// - Returns: return final string with replacement
    mutating func replaceWhiteSpace(_ withString: String) -> String {
        let components = self.components(separatedBy: CharacterSet.whitespaces)
        let filtered = components.filter({!$0.isEmpty})
        return filtered.joined(separator: "")
    }
    
    
    /// give string witdh
    ///
    /// - Parameters:
    ///   - textHeight: give height what you need in width
    ///   - textFont: pass font
    /// - Returns: return width as per height and font
    func textWidth(_ textHeight: CGFloat, textFont: UIFont) -> CGFloat {
        let textRect: CGRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: textHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        let textSize: CGSize = textRect.size
        return ceil(textSize.width)
    }
    
    
    /// give string height as per width and font
    ///
    /// - Parameters:
    ///   - textWidth: pass fix width
    ///   - textFont: pass font
    /// - Returns: retun height as per width and font
    func textHeight(_ textWidth: CGFloat, textFont: UIFont) -> CGFloat {
        let textRect: CGRect = self.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        let textSize: CGSize = textRect.size
        return ceil(textSize.height)
    }
    
    func textSize(_ textFont: UIFont) -> CGSize {
        let textRect: CGRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil)
        return textRect.size;
    }
    
    /// Trim whire space from before and ending
    ///
    /// - Returns: retun string from remove white space
    func trimWhiteSpace() -> String
    {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    /// trime white space and new line give final string
    ///
    /// - Returns:
    func trim() -> String { return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    
    /// trim white space from first and last possition
    ///
    /// - Returns: remove space from first and last
    func trimTrailingWhitespace() -> String {
        if let trailingWs = self.range(of: "\\s+$", options: .regularExpression) {
            return self.replacingCharacters(in: trailingWs, with: "")
        } else {
            return self
        }
    }
    
    /// get phone number from string
    ///
    /// - Returns:
    mutating func extractPhoneNo() -> String {
        self = self.trim()
        return self
    }
    
    
    func leftPadding(toLength: Int, withPad: String = " ") -> Int {
        guard toLength > self.count else { return Int(self)! }
        let padding = String(repeating: withPad, count: toLength - self.count)
        return Int(padding + self)!
    }
    
    
    /// check is string content emoji
    ///
    /// - Returns: return value bool yes if have emoji
    func containsEmoji() -> Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                 0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF, // Transport and Map
                 0x2600...0x26FF,   // Misc symbols
                 0x2700...0x27BF,   // Dingbats
                 0xFE00...0xFE0F:   // Variation Selectors
                return true
            default:
                continue
            }
        }
        return false
    }
    
    
    
    /// convert string to url (NOTE: if string are already content %20 then don't use this )
    ///
    /// - Returns: return url of given string with replce of http or any other extance
    func convertToUrl() -> URL {
        let data:Data = self.data(using: String.Encoding.utf8)!
        var resultStr: String = String(data: data, encoding: String.Encoding.nonLossyASCII)!
        
        if !(resultStr.hasPrefix("itms://")) && !(resultStr.hasPrefix("file://")) && !(resultStr.hasPrefix("http://")) && !(resultStr.hasPrefix("skype:")) && !(resultStr.hasPrefix("https://")) { resultStr = "http://" + resultStr }
        
        resultStr = resultStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        return URL(string: resultStr)!
    }
    
    
    /// encoding the strong
    ///
    /// - Returns: <#return value description#>
    mutating func encode() -> String {
        let customAllowedSet =  CharacterSet(charactersIn:" !+=\"#%/<>?@\\^`{|}$&()*-").inverted
        self = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)!
        return self
    }
    
    
    /// check string is contnt numrical value or not
    ///
    /// - Returns: return yes if numric
    func isNumeric() -> Bool {
        var holder: Float = 0.00
        let scan: Scanner = Scanner(string: self)
        let RET: Bool = scan.scanFloat(&holder) && scan.isAtEnd
        if self == "." { return false }
        return RET
    }
    
    
    /// comper two string and retun is that string content other string
    ///
    /// - Parameter subString: pass the string what you want to check
    /// - Returns: return with is contain then true or not then false
    func isContainString(_ subString: String) -> Bool {
        let range = self.range(of: subString, options: NSString.CompareOptions.caseInsensitive, range: self.range(of: self))
        return range == nil ? false : true
    }
    
    
    /// return locaized string
    ///
    /// - Parameter language: pass language what you want
    /// - Returns: localize string with given language
    func localized(forLanguage language: String = Locale.preferredLanguages.first!.components(separatedBy: "-").first!) -> String {
        guard let path = Bundle.main.path(forResource: language == "en" ? "Base" : language, ofType: "lproj") else {
            let basePath = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            return Bundle(path: basePath)!.localizedString(forKey: self, value: "", table: nil)
        }
        return Bundle(path: path)!.localizedString(forKey: self, value: "", table: nil)
    }
    
    /// set thousand seperator
    ///
    /// - Returns: return value with 2 decimal point
    func setThousandSeperator() ->String {
        return self.setThousandSeperator(self, decimal: 2)
    }
    
    /// set thousand seperator
    ///
    /// - Returns: return value with 2 decimal point
    func setThousandSeperator(decimal:Int) ->String {
        return self.setThousandSeperator(self, decimal: decimal)
    }
    
    /// set thousand seperator with given decimal number
    ///
    /// - Parameters:
    ///   - string: pass sting of what you want thousand saprator
    ///   - decimal: pass decimal point
    /// - Returns: return value with passed
    func setThousandSeperator(_ string: String, decimal: Int) -> String {
        let numberFormatter = NumberFormatter.init()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        //        numberFormatter.locale = Locale.init(identifier: "en_IN")
        //        numberFormatter.currencyCode = "INR"
        numberFormatter.currencySymbol = ""
        numberFormatter.decimalSeparator = "."
        numberFormatter.maximumFractionDigits = decimal
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.usesGroupingSeparator = true
        if string.isEmpty { return "0.00" }
        return numberFormatter.string(from: NSNumber.init(value: Double(string)! as Double))!
    }
    
    
    /// give two decimal point value
    ///
    /// - Returns: <#return value description#>
    func setDecimalPoint() -> String {
        let numberFormatter:NumberFormatter = NumberFormatter.init()
        numberFormatter.decimalSeparator = "."
        numberFormatter.maximumFractionDigits = 2
        return  numberFormatter.string(from: NSNumber.init(value: Double(self)! as Double))!
    }
    
    
    /// validate mobile number with regex
    ///
    /// - Returns: true for right number faluse for not right
    func validateMobileNo() -> Bool {
        do {
            let pattern: String = "^[6789]\\d{9}$"
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = self as NSString
            let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
            return results.count > 0 ? true : false
            
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    
    /// validate email formate
    ///
    /// - Returns: true if right false for wrong
    func validateEmail() -> Bool {
        do {
            let pattern: String = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            //  let pattern: String = "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?"
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = self as NSString
            let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
            return results.count > 0 ? true : false
            
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    /// validation of password rang 6 to 32
    ///
    /// - Returns: true for valid 6 digit pass or wrong false for
    func validatePassword() -> Bool {
        return self.count >= 6 && self.count <= 32 ? true : false
    }
    
    /// make json string to dic
    ///
    /// - Returns: typeAliasStringDictionary
    func convertToStringDictionary() -> typeAliasStringDictionary {
        let jsonData: Data = self.data(using: String.Encoding.utf8)!
        do {
            let dict: typeAliasStringDictionary = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! typeAliasStringDictionary
            return dict
        } catch let error as NSError { print(error) }
        return typeAliasStringDictionary()
    }
    
    
    /// make json string to typeAliasDictionary
    ///
    /// - Returns: return value typeAliasDictionary
    func convertToDictionary() -> typeAliasDictionary {
        let jsonData: Data = self.data(using: String.Encoding.utf8)!
        do {
            let dict: typeAliasDictionary = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! typeAliasDictionary
            return dict
        } catch let error as NSError { print(error) }
        return typeAliasDictionary()
    }
    
    
    /// make json to array
    ///
    /// - Returns: return value dic value in array
    func convertToArray() -> [typeAliasDictionary] {
        let jsonData: Data = self.data(using: String.Encoding.utf8)!
        do {
            let array: [typeAliasDictionary] = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! [typeAliasDictionary]
            return array
        } catch let error as NSError { print(error) }
        
        return [typeAliasDictionary]()
    }
    
    
    /// make json to string array
    ///
    /// - Returns: return value string array
    func convertToStringArray() -> [String] {
        let jsonData: Data = self.data(using: String.Encoding.utf8)!
        do {
            let array: [String] = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! [String]
            return array
        } catch let error as NSError { print(error) }
        
        return [String]()
    }
    /*
     /// encode in base 64
     ///
     /// - Returns: return value base 64
     func base64Encoded() -> String {
     if let data = self.data(using: .utf8) { return data.base64EncodedString() }
     return ""
     }
     
     /// decode from base64
     ///
     /// - Returns: return value of base 64
     func base64Decoded() -> String {
     if let data = Data(base64Encoded: self) { return String(data: data, encoding: .utf8)! }
     return ""
     }
     */
    
    /// hex string to UIColor
    ///
    /// - Returns: UIColor
    func hexToUIColor () -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }
        
        if ((cString.count) != 6) { return UIColor.gray }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    /// get redians form given string digree
    ///
    /// - Returns: <#return value description#>
    func getRediansFromDegrees() -> Double {
        let degree: Double = Double(self)!
        return degree * .pi / 180.0
    }
    
    
    func extractString(_ checkingType: NSTextCheckingResult.CheckingType) -> [String] {
        var arrText = [String]()
        let detector = try! NSDataDetector(types: checkingType.rawValue)
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
        
        for match in matches {
            let url = (self as NSString).substring(with: match.range)
            arrText.append(url)
        }
        return arrText
    }
    
    
    
    /// get phone number from give string
    ///
    /// - Returns: <#return value description#>
    func getPhoneNumber() -> [String] { return self.extractString(.phoneNumber) }
    
    
    /// get url from string
    ///
    /// - Returns: <#return value description#>
    func getUrl() -> [String]  { return self.extractString(.link) }
    
    /// get address from string
    ///
    /// - Returns: <#return value description#>
    func getAddress() -> [String]  { return self.extractString(.address) }
    
    /// get email address from string
    ///
    /// - Returns: <#return value description#>
    func getEmail() -> [String]  {
        var arrEmail = [String]()
        let arrText = self.components(separatedBy: ["\n"," ","."])
        for st in arrText {
            let isEmail: Bool = st.validateEmail()
            if isEmail { arrEmail.append(st) }
        }
        return arrEmail
    }
    
    /// get all int value from string
    var getIntergerFromString: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars.compactMap { pattern ~= $0 ? Character($0) : nil })
    }
    
    
    /// add % endcoing value
    ///
    /// - Returns: <#return value description#>
    public func addingPercentEncodingForQueryParameter() -> String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed)
    }
    
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the amount of nanoseconds from another date
    func nanoseconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        var _: String = ""
        //        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        //        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        //        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if seconds(from: date) > 0 { return "\(seconds(from: date))" }
        //        if days(from: date)    > 0 { result = result + " " + "\(days(from: date)) D" }
        //        if hours(from: date)   > 0 { result = result + " " + "\(hours(from: date)) H" }
        //        if minutes(from: date) > 0 { result = result + " " + "\(minutes(from: date)) M" }
        //        if seconds(from: date) > 0 { return "\(seconds(from: date))" }
        return ""
    }
    
    func localizedDateOnly( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    // Calling part
    // Date().millisecondsSince1970 // 1476889390939
    // Date(milliseconds: 1476889390939)
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func calenderTimeSinceNow() -> String {
        let calender = Calendar.current
        
        let components = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        let years = components.year!
        let months = components.month!
        let days = components.day!
        let hours = components.hour!
        let minutes = components.minute!
        let seconds = components.second!
        
        if years > 0 {
            return years == 1 ? "1 year ago" : "\(years) years ago"
        } else if months > 0 {
            return months == 1 ? "1 month ago" : "\(months) months ago"
        } else if days >= 7 {
            let weeks = days / 7
            return weeks == 1 ? "1 week ago" : "\(weeks) weeks ago"
        } else if days > 0 {
            return days == 1 ? "1 day ago" : "\(days) day ago"
        } else if hours > 0 {
            return hours == 1 ? "1 hour ago" : "\(hours) hour ago"
        } else if minutes > 0 {
            return minutes == 1 ? "1 min ago" : "\(minutes) min ago"
        } else {
            return seconds == 1 ? "1 sec ago" : "\(seconds) sec ago"
        }
    }
}


extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
        
        return allowed
    }()
}

extension Dictionary {
    
    func nullKeyRemoval() -> [AnyHashable: Any] {
        var dict: [AnyHashable: Any] = self
        
        let keysToRemove = dict.keys.filter { dict[$0] is NSNull }
        let keysToCheck = dict.keys.filter({ dict[$0] is Dictionary })
        let keysToArrayCheck = dict.keys.filter({ dict[$0] is [Any] })
        for key in keysToRemove {
            dict[key] = ""
        }
        for key in keysToCheck {
            if let valueDict = dict[key] as? [AnyHashable: Any] {
                dict.updateValue(valueDict.nullKeyRemoval(), forKey: key)
            }
        }
        for key in keysToArrayCheck {
            if var arrayDict = dict[key] as? [Any] {
                for i in  0..<arrayDict.count {
                    if let dictObj = arrayDict[i] as? typeAliasDictionary {
                        arrayDict[i] = dictObj.nullKeyRemoval()
                    }
                }
                dict.updateValue(arrayDict, forKey: key)
            }
        }
        return dict
    }
    
    /// convert dictionary to json string
    ///
    /// - Returns: <#return value description#>
    func convertToJSonString() -> String {
        do {
            let dataJSon = try JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted)
            let st: NSString = NSString.init(data: dataJSon, encoding: String.Encoding.utf8.rawValue)!
            return st as String
        } catch let error as NSError { print(error) }
        return ""
    }
    
    
    /// check given key have value or not
    ///
    /// - Parameter stKey: pass key what you want check
    /// - Returns: true if exist
    func isKeyNull(_ stKey: String) -> Bool {
        let dict: typeAliasDictionary = (self as AnyObject) as! typeAliasDictionary
        if let val = dict[stKey] { return val is NSNull ? true : false }
        return true
    }
    
    
    /// handal carsh when null valu or key not found
    ///
    /// - Parameter stKey: pass the key of object
    /// - Returns: blank string or value if exist
    func valuForKeyBool(_ stKey: String) -> Bool {
        let dict: typeAliasDictionary = (self as AnyObject) as! typeAliasDictionary
        if let val = dict[stKey] {
            if val is NSNull {
                return false
            } else if (val as? NSNumber) != nil {
                return  (val as AnyObject).boolValue
            } else if (val as? Bool) != nil {
                return val as! Bool
            } else if val is String {
                if (val as! String) == "0" {
                    return false
                } else {
                    return true
                }
            } else if val is Int {
                if (val as! Int) == 0 {
                    return false
                } else {
                    return true
                }
            }
        }
        return false
    }
    
    
    /// handal carsh when null valu or key not found
    ///
    /// - Parameter stKey: pass the key of object
    /// - Returns: blank string or value if exist
    func valuForKeyString(_ stKey: String) -> String {
        let dict: typeAliasDictionary = (self as AnyObject) as! typeAliasDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                return ""
            }else if (val as? NSNumber) != nil {
                return  (val as AnyObject).stringValue //val.stringValue
                
            }else if (val as? String) != nil {
                return val as! String
            }else{
                return val as! String
            }
        }
        return ""
    }
    
    /// handal carsh when null valu or key not found
    ///
    /// - Parameter stKey: pass the key of object
    /// - Returns: blank string or value if exist
    func valuForKeyDic(_ stKey: String) -> typeAliasDictionary {
        let dictMain: typeAliasDictionary = (self as AnyObject) as! typeAliasDictionary
        let dic:typeAliasDictionary = typeAliasDictionary()
        if let val = dictMain[stKey] {
            if val is NSNull{
                return dic
            } else if val is [String:Any] {
                return val as! typeAliasDictionary
            }
        }
        return dic
    }
    
    
    func valuForKeyInt( _ any:String) -> Int {
        var iValue: Int = 0
        let dict: typeAliasDictionary = self as! typeAliasDictionary
        if let val = dict[any] {
            if val is NSNull {
                return 0
            }
            else {
                if val is Int {
                    iValue = val as! Int
                }
                else if val is Double {
                    iValue = Int(val as! Double)
                }
                else if val is String {
                    let stValue: String = val as! String
                    iValue = (stValue as NSString).integerValue
                }
                else if val is Float {
                    iValue = Int(val as! Float)
                }else{
                    _ = NSError(domain:any, code: 100, userInfo:dict) //let = error
                }
            }
        }
        return iValue
    }
    
    func valuForKeyFloat( _ any:String) -> Float {
        return valuForKeyFloat(any,nullValue: 0.0)
    }
    
    func valuForKeyFloat( _ any:String,nullValue :Float ) -> Float {
        var fValue: Float = nullValue
        let dict: typeAliasDictionary = self as! typeAliasDictionary
        if let val = dict[any] {
            if val is NSNull {
                return fValue
            }
            else {
                if val is Int {
                    fValue = val as! Float
                }
                else if val is Double {
                    fValue = Float(val as! Double)
                }
                else if val is String {
                    let stValue: String = val as! String
                    fValue = (stValue as NSString).floatValue
                }
                else if val is Float {
                    fValue = Float(val as! Float)
                }else{
                    _ = NSError(domain:any, code: 100, userInfo:dict)//let error
                    //Crashlytics.sharedInstance().recordError(error)
                }
            }
        }
        return fValue
    }
    
    func valuForKeyDouble( _ any:String) -> Double {
        return valuForKeyDouble(any,nullValue: 0.0)
    }
    
    func valuForKeyDouble( _ any:String,nullValue :Double ) -> Double {
        var dValue: Double = nullValue
        let dict: typeAliasDictionary = self as! typeAliasDictionary
        if let val = dict[any] {
            if val is NSNull {
                return dValue
            }
            else {
                if val is Int {
                    dValue = val as! Double
                }
                else if val is Double {
                    dValue = Double(val as! Double)
                }
                else if val is String {
                    let stValue: String = val as! String
                    dValue = (stValue as NSString).doubleValue
                }
                else if val is Float {
                    dValue = Double(val as! Double)
                }else{
                    _ = NSError(domain:any, code: 100, userInfo:dict)//let error
                    //Crashlytics.sharedInstance().recordError(error)
                }
            }
        }
        return dValue
    }
    
    
    
    ///expaned function of null value
    func valuForKeyString(_ stKey: String,nullvalue:String) -> String {
        return  self.valuForKeyWithNullString(Key: stKey, NullReplaceValue: nullvalue)
    }
    
    /// Update dic with other Dictionary
    ///
    /// - Parameter other: add second Dictionary which one you want to add
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    
    
    /// USE TO GET VALUE FOR KEY if key not found or null then replace with the string
    ///
    /// - Parameters:
    ///   - stKey: pass key of dic
    ///   - NullReplaceValue: set value what you want retun if that key is nill
    /// - Returns: retun key value if exist or return null replace value
    func valuForKeyWithNullString(Key stKey: String,NullReplaceValue:String) -> String {
        let dict: typeAliasDictionary = (self as AnyObject) as! typeAliasDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                dLog(message: val)
                return NullReplaceValue
            } else{
                if (val as? NSNumber) != nil {
                    return  (val as AnyObject).stringValue //val.stringValue
                }else{
                    return val as! String == "" ? NullReplaceValue : val as! String
                }
            }
        }
        return NullReplaceValue
    }
    
    func valuForKeyWithNullWithReplaceString(Key stKey: String,NullReplaceValue:String) -> String {
        let dict: typeAliasDictionary = (self as AnyObject) as! typeAliasDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                dLog(message: val)
                return NullReplaceValue
            } else{
                if (val as? NSNumber) != nil {
                    if Int(truncating: val as! NSNumber) > 0{
                        return  "+" + (val as AnyObject).stringValue //"+" + val.stringValue
                    }
                }else{
                    if Int(val as! String) > 0{
                        return val as! String == "" ? NullReplaceValue : "+" + (val as! String)
                    }else{
                        return val as! String == "" ? NullReplaceValue : val as! String
                    }
                    
                }
            }
        }
        return NullReplaceValue
    }
    
    func valuForKeyArray(_ stKey: String) -> Array<Any> {
        let dict: typeAliasDictionary = (self as AnyObject) as! typeAliasDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                return []
            } else{
                return val as! Array<Any>
            }
        }
        return []
    }
    
    /// This is function for convert dicticonery to xml string also check log for other type of string i only handal 2 or 3 type of stct
    ///
    /// - Returns: return xml string
    func createXML()-> String{
        
        var xml = ""
        for k in self.keys {
            
            if let str = self[k] as? String{
                xml.append("<\(k as! String)>")
                xml.append(str)
                xml.append("</\(k as! String)>")
                
            }else if let dic =  self[k] as? Dictionary{
                xml.append("<\(k as! String)>")
                xml.append(dic.createXML())
                xml.append("</\(k as! String)>")
                
            }else if let array : NSArray =  self[k] as? NSArray{
                for i in 0..<array.count {
                    xml.append("<\(k as! String)>")
                    if let dic =  array[i] as? Dictionary{
                        xml.append(dic.createXML())
                    }else if let str = array[i]  as? String{
                        xml.append(str)
                    }else{
                        dLog(message: array[i])
                        fatalError("[XML]  associated with \(self[k] as Any) not any type!")
                    }
                    xml.append("</\(k as! String)>")
                    
                }
            }else if let dic =  self[k] as? NSDictionary{
                xml.append("<\(k as! String)>")
                
                let newdic = dic as! Dictionary<String,Any>
                xml.append(newdic.createXML())
                xml.append("</\(k as! String)>")
                
            }
            else{
                dLog(message: self[k] as Any)
                fatalError("[XML]  associated with \(self[k] as Any) not any type!")
            }
        }
        
        return xml
    }
    
    
}


extension Array {
    
    func indexExists(_ index: Int) -> Bool {
        return self.indices.contains(index)
    }
    
    func convertToJSonString() -> String {
        do {
            let dataJSon = try JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted)
            //let st: NSString = NSString.init(data: dataJSon, encoding: String.Encoding.utf8.rawValue)!
            let st: String = String(data: dataJSon, encoding: .utf8)!
            return st
        } catch let error as NSError { print(error) }
        return ""
    }
    
    func getArrayFromArrayOfDictionary(key: String, valueString: String, valueInt: String) -> [typeAliasDictionary] {
        if !valueString.isEmpty {
            let predicate = NSPredicate(format: "%K LIKE[cd] %@", key, valueString)
            print(predicate)
            return (self as NSArray).filtered(using: predicate) as! [typeAliasDictionary]
        }
        else if !valueInt.isEmpty {
            let predicate = NSPredicate(format: "%K = %d", key, Int(valueInt)!)
            return (self as NSArray).filtered(using: predicate) as! [typeAliasDictionary]
        }
        return [typeAliasDictionary]()
    }
    
    func getArrayFromArrayOfDictionaryKeys(key: String, valueArray: NSArray) -> [typeAliasDictionary] {
        if valueArray.count > 0 {
            let pridictarray = NSMutableArray()
            for value in valueArray{
                let predicate = NSPredicate(format: "%K LIKE[cd] %@", key, value as! CVarArg)
                pridictarray.add(predicate)
                
            }
            let andPredicate = NSCompoundPredicate(type: .or, subpredicates: pridictarray as! [NSPredicate] )
            
            print(andPredicate)
            return (self as NSArray).filtered(using: andPredicate) as! [typeAliasDictionary]
        }
        
        return [typeAliasDictionary]()
    }
    
    func getArrayFromArrayOfDictionary(key: String, notValueString: [String], notValueInt: [String]) -> [typeAliasDictionary] {
        if !notValueString.isEmpty {
            var arrCondition = [String]()
            for value in notValueString { arrCondition.append("(NOT \(key) LIKE[cd] \"\(value)\")") }
            let stCondition: String = arrCondition.joined(separator: " AND ")
            
            let predicate = NSPredicate(format: stCondition)
            return (self as NSArray).filtered(using: predicate) as! [typeAliasDictionary]
        }
        else if !notValueInt.isEmpty {
            //            let predicate = NSPredicate(format: "%K != %d", key, Int(notValueInt)!)
            //            return (self as NSArray).filtered(using: predicate) as! [typeAliasDictionary]
        }
        
        return [typeAliasDictionary]()
    }
    
    func getArrayFromArrayOfDictionary2(key: String, valueString: String, valueInt: String) -> [typeAliasStringDictionary] {
        if !valueString.isEmpty {
            let predicate = NSPredicate(format: "%K LIKE[cd] %@", key, valueString)
            return (self as NSArray).filtered(using: predicate) as! [typeAliasStringDictionary]
        }
        else if !valueInt.isEmpty {
            let predicate = NSPredicate(format: "%K = %d", key, Int(valueInt)!)
            return (self as NSArray).filtered(using: predicate) as! [typeAliasStringDictionary]
        }
        return [typeAliasStringDictionary]()
    }
    
    func getArrayFromArrayOfString(valueString: String, valueInt: String) -> [String] {
        
        if !valueString.isEmpty {
            let predicate = NSPredicate(format: "SELF LIKE[cd] %@", valueString)
            return (self as NSArray).filtered(using: predicate) as! [String]
        }
        else if !valueInt.isEmpty {
            let predicate = NSPredicate(format: "SELF = %d", Int(valueInt)!)
            return (self as NSArray).filtered(using: predicate) as! [String]
        }
        
        return [String]()
    }
}

extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.index(string.startIndex, offsetBy: location)
        let endIndex = string.index(startIndex, offsetBy: length)
        return startIndex..<endIndex
    }
}

extension UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    /// Returns the first constraint with the given identifier, if available.
    ///
    /// - Parameter identifier: The constraint identifier.
    func constraintWithIdentifier(_ identifier: String) -> NSLayoutConstraint? {
        return self.constraints.first { $0.identifier == identifier }
    }
    
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    class func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(nibName: nibNamed, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    func cornerRound(roundingCorners corners: UIRectCorner, radius: CGFloat) -> Void {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func cornerReverse(ConcaveRoundingCorners corners: UIRectCorner, radius: CGFloat) -> Void {
        let path = UIBezierPath()
        let rect = self.bounds
        var cornerRadius = radius
        let halfWidth: CGFloat = rect.width / 2
        let halfHeight: CGFloat = rect.height / 2
        if cornerRadius > halfWidth || cornerRadius > halfHeight {
            cornerRadius = min(halfWidth, halfHeight)
        }
        
        let topLeft = CGPoint(x: rect.minX, y: rect.minY)
        if corners.rawValue & UIRectCorner.topLeft.rawValue != 0 {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y + cornerRadius))
            path.addArc(withCenter: topLeft, radius: cornerRadius, startAngle: CGFloat(Double.pi), endAngle: 0, clockwise: false)
        } else {
            path.move(to: topLeft)
        }
        
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        if corners.rawValue & UIRectCorner.topRight.rawValue != 0 {
            path.addLine(to: CGPoint(x: topRight.x - cornerRadius, y: topRight.y))
            path.addArc(withCenter: topRight, radius: cornerRadius, startAngle: .pi, endAngle: CGFloat(Double.pi), clockwise: false)
        } else {
            path.addLine(to: topRight)
        }
        
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        if corners.rawValue & UIRectCorner.bottomRight.rawValue != 0 {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - cornerRadius))
            path.addArc(withCenter: bottomRight, radius: cornerRadius, startAngle: CGFloat(Double.pi * 3), endAngle: .pi, clockwise: false)
        } else {
            path.addLine(to: bottomRight)
        }
        
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        if corners.rawValue & UIRectCorner.bottomLeft.rawValue != 0 {
            path.addLine(to: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y))
            path.addArc(withCenter: bottomLeft, radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi * 3), clockwise: false)
        } else {
            path.addLine(to: bottomLeft)
        }
        
        // Complete the path
        path.close()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func setHighlight() {
        self.setViewBorder(UIColor.black, borderWidth: 2, isShadow: false, cornerRadius: 0, backColor: UIColor.clear)
    }
    
    func unSetHighlight() {
        self.setViewBorder(UIColor.black, borderWidth: 1, isShadow: false, cornerRadius: 0, backColor: UIColor.clear)
    }
    
    func setBottomBorder(_ borderColor: UIColor, borderWidth: CGFloat) {
        let tagLayer: String = "100000"
        if self.layer.sublayers?.count > 1 && self.layer.sublayers?.last?.accessibilityLabel == tagLayer {
            self.layer.sublayers?.last?.removeFromSuperlayer()
        }
        let border: CALayer = CALayer()
        border.backgroundColor = borderColor.cgColor;
        border.accessibilityLabel = tagLayer;
        border.frame = CGRect(x: 0, y: self.frame.height - borderWidth, width: self.frame.width, height: borderWidth);
        self.layer.addSublayer(border)
    }
    
    func setViewBorder(_ borderColor: UIColor, borderWidth: CGFloat, isShadow: Bool, cornerRadius: CGFloat, backColor: UIColor) {
        self.backgroundColor = backColor;
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.cgColor;
        self.layer.cornerRadius = cornerRadius;
    }
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func dropShadowed() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.cornerRadius = 16
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale  
    }
    
    func dropShadowed(cornerRadius:CGFloat) {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.cornerRadius = cornerRadius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func dropShadowed(cornerRadius:CGFloat, spreadRadius:CGFloat, shadowColor:UIColor? = UIColor.lightGray, borderColor: UIColor? = UIColor.lightGray, borderWidth:CGFloat? = 0.3) {
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = spreadRadius
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth!
        layer.shadowPath = nil //UIBezierPath(rect: self.bounds).cgPath
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func dropShadowed(cornerRadius:CGFloat, borderColor: UIColor, borderWidth:CGFloat) {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func dropShadowed(cornerRadius:CGFloat, borderColor: UIColor, borderWidth:CGFloat, shadowColor:UIColor) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 5)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.shadowPath = nil//UIBezierPath(rect: self.bounds.insetBy(dx: -2, dy: -2)).cgPath
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func dropShadowed(cornerRadius:CGFloat, corners: UIRectCorner, borderColor: UIColor, borderWidth:CGFloat, shadowColor:UIColor) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        layer.mask?.shadowPath = path.cgPath
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.cornerRadius = cornerRadius
        
        if corners.contains(.topLeft) && corners.contains(.topRight) {
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        if corners.contains(.bottomLeft) && corners.contains(.bottomRight)  {
            layer.maskedCorners = [.layerMinXMaxYCorner,  .layerMaxXMaxYCorner]
        }
        if corners.contains(.topLeft) && corners.contains(.bottomLeft) {
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
        if corners.contains(.topRight) && corners.contains(.bottomRight)  {
            layer.maskedCorners = [.layerMaxXMinYCorner,  .layerMaxXMaxYCorner]
        }
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.shadowPath =  nil//path.cgPath
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, color:UIColor? = UIColor.lightGray) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color?.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    func drawDottedLine(_ color:UIColor = .lightGray) {
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = 1
        dashBorder.strokeColor = color.cgColor
        dashBorder.lineDashPattern = [7,4] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
    }
    func dropShadow(scale: Bool = true, color: UIColor? = UIColor.black) {
        layer.masksToBounds = false
        layer.shadowColor = color?.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 4
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
    }
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: convertFromCATransitionType(CATransitionType.fade))
    }
    
    @IBInspectable
    var ShadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable
    var ShadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable
    var ShadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable
    var ShadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
                layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
                layer.masksToBounds = false
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    /**
     Set x Position
     
     :param: x CGFloat
     by Kishan Sutariya
     */
    func setX(x:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    /**
     Set y Position
     
     :param: y CGFloat
     by Kishan Sutariya
     */
    func setY(y:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    
    func setWidth(width:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    
    func setHeight(height:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
    
    func LableWithTag(_ tag:Int) -> UILabel {
        if let lable = self.viewWithTag(tag){
            return lable as! UILabel
        }
        return  UILabel()
    }
    func ImageViewWithTag(_ tag:Int) -> UIImageView {
        if let lable = self.viewWithTag(tag){
            return lable as! UIImageView
        }
        return  UIImageView()
    }
    func ButtonWithTag(_ tag:Int) -> UIButton {
        if let lable = self.viewWithTag(tag){
            return lable as! UIButton
        }
        return  UIButton()
    }
    
    func TextFiledWithTag(_ tag:Int) -> UITextField {
        if let lable = self.viewWithTag(tag){
            return lable as! UITextField
        }
        return  UITextField()
    }
    
    var globalFrame: CGRect? {
        let rootView = UIApplication.shared.keyWindowInConnectedScenes?.rootViewController?.view
        return self.superview?.convert(self.frame, to: rootView)
    }
    
    
    func heightConstraint(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }
    
    func widthConstraint(constant: CGFloat) {
        setConstraint(value: constant, attribute: .width)
    }
    
    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach {
            if $0.firstAttribute == attribute {
                removeConstraint($0)
            }
        }
    }
    
    private func setConstraint(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
        removeConstraint(attribute: attribute)
        let constraint =
            NSLayoutConstraint(item: self,
                               attribute: attribute,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: nil,
                               attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                               multiplier: 1,
                               constant: value)
        self.addConstraint(constraint)
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            // swiftlint:disable:next force_unwrapping
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    var parentNavigationController: UINavigationController? {
        let currentViewController = parentViewController
        if let navigationController = currentViewController as? UINavigationController {
            return navigationController
        }
        return currentViewController?.navigationController
    }
    
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate360Degrees(duration: CFTimeInterval = 2.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi)
        rotateAnimation.duration = duration
        
        if let delegate: CAAnimationDelegate = completionDelegate as! CAAnimationDelegate? {
            rotateAnimation.delegate = delegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func rotate(duration: Double = 1, clockWise:Bool = true) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = clockWise ? -Float.pi * 2.0 : Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func height(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }
    
    func width(constant: CGFloat) {
        setConstraint(value: constant, attribute: .width)
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}


extension UISegmentedControl {
    func setCubberLayout() {
        //        if #available(iOS 9.0, *) {
        //            UILabel.appearanceWhenContainedInInstancesOfClasses([UISegmentedControl.self]).numberOfLines = 0
        //        } else {
        //            // Fallback on earlier versions
        //        }
        self.tintColor = UIColor.blue
        self.subviews[0].tintColor = UIColor.yellow
        self.titleForSegment(at: 0)
    }
}

extension UITextView {
    
    func resolveHashTags() {
        
        // turn string in to NSString
        let nsText:NSString = self.text as NSString
        
        // this needs to be an array of NSString.  String does not work.
        let words:[NSString] = nsText.components(separatedBy: " ") as [NSString]
        
        // you can't set the font size in the storyboard anymore, since it gets overridden here.
        let attrs = [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0) ]
        
        // you can staple URLs onto attributed strings
        let attrString = NSMutableAttributedString(string: nsText as String, attributes:attrs)
        
        // tag each word if it has a hashtag
        for word in words {
            
            // found a word that is prepended by a hashtag!
            // homework for you: implement @mentions here too.
            if word.hasPrefix("#") {
                
                // a range is the character position, followed by how many characters are in the word.
                // we need this because we staple the "href" to this range.
                let matchRange:NSRange = nsText.range(of: word as String)
                
                // convert the word from NSString to String
                // this allows us to call "dropFirst" to remove the hashtag
                let stringifiedWord:String = word as String
                
                // drop the hashtag
                //            stringifiedWord = String(stringifiedWord.characters.dropFirst())
                
                // check to see if the hashtag has numbers.
                // ribl is "#1" shouldn't be considered a hashtag.
                let digits = NSCharacterSet.decimalDigits
                
                if stringifiedWord.rangeOfCharacter(from: digits) != nil {
                    // hashtag contains a number, like "#1"
                    // so don't make it clickable
                } else {
                    // set a link for when the user clicks on this word.
                    // it's not enough to use the word "hash", but you need the url scheme syntax "hash://"
                    // note:  since it's a URL now, the color is set to the project's tint color
                    attrString.addAttribute(NSAttributedString.Key.link, value: "hash:\(stringifiedWord)", range: matchRange)
                }
                
            }
        }
        
        // we're used to textView.text
        // but here we use textView.attributedText
        // again, this will also wipe out any fonts and colors from the storyboard,
        // so remember to re-add them in the attrs dictionary above
        self.attributedText = attrString
    }
    
    func getHashTags() -> [String]? {
        var hasTags:[String]? = []
        let nsText:NSString = self.text as NSString
        let words:[NSString] = nsText.components(separatedBy: " ") as [NSString]
        for word in words {
            if word.hasPrefix("#") {
                let stringifiedWord:String = word as String
                
                let digits = NSCharacterSet.decimalDigits
                
                if stringifiedWord.rangeOfCharacter(from: digits) != nil {
                    
                } else {
                    hasTags?.append(stringifiedWord)
                }
                
            }
        }
        return hasTags
    }
    
}

extension URL {
    func getDataFromQueryString() -> typeAliasStringDictionary {
        let urlComponents: URLComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        let arrQueryItems: Array<URLQueryItem> = urlComponents.queryItems!
        var dictParams = typeAliasStringDictionary()
        for item:URLQueryItem in arrQueryItems { dictParams[item.name] = item.value }
        return dictParams
    }
}
extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
    
    func scrollToBottom() {
        if contentSize.height < bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        setContentOffset(bottomOffset, animated: true)
    }
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}
extension UIFont {
    static let themeFontSize = UIFont(name: "Montserrat-Regular", size: 13)
}
extension UIColor {
    
    /// color with int
    ///
    /// - Parameters:
    ///   - red: value of rad
    ///   - green: value of green
    ///   - blue: value of blue
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(r: Int, g: Int, b: Int , a:CGFloat ) {
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    
    static let themeColor = UIColor(hexString: "#FBBA00")
    static let themeFontColor = UIColor(hexString: "#212621")
    static let themeFontLightColor = UIColor(hexString: "#8C98A9")
    static let themeGreenColor = UIColor(hexString: "#6DA544")
    static let themeYellowColor = UIColor(hexString: "#FF9811")
    static let themeDarkGreyColor = UIColor(hexString: "#1D1E1F")
    static let themeLightColor = UIColor(hexString:"#FFBA00").withAlphaComponent(0.5)
    static let themeRedColor = UIColor(hexString:"#FF8872")
    static let themeBlackColor = UIColor(hexString: "#000000")
    /// color with hax string
    ///
    /// - Parameter hexString: <#hexString description#>
    convenience init(hexString:String) {
        var hexString:String = hexString.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if (hexString.hasPrefix("#")) { hexString.remove(at: hexString.startIndex) }
        
        var color:UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(displayP3Red: red, green: green, blue: blue, alpha: 1)
        //self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    
    /// uicolor to hex string
    ///
    /// - Returns: <#return value description#>
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
    
    
}

/*
 Block of UIControl
 */

/// Typealias for UIBarButtonItem closure.
typealias UIBarButtonItemTargetClosure = (UIBarButtonItem) -> ()

class UIBarButtonItemClosureWrapper: NSObject {
    let closure: UIBarButtonItemTargetClosure
    init(_ closure: @escaping UIBarButtonItemTargetClosure) {
        self.closure = closure
    }
}

extension UIBarButtonItem {
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIBarButtonItemTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIBarButtonItemClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIBarButtonItemClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    convenience init(title: String?, style: UIBarButtonItem.Style, closure: @escaping UIBarButtonItemTargetClosure) {
        self.init(title: title, style: style, target: nil, action: nil)
        targetClosure = closure
        action = #selector(UIBarButtonItem.closureAction)
    }
    
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}

//class ClosureSleeve {
//    let closure: () -> ()
//    
//    init(attachTo: AnyObject, closure: @escaping () -> ()) {
//        self.closure = closure
//        objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
//    }
//    
//    @objc func invoke() {
//        closure()
//    }
//}


extension UIControl {
    //    func addAction(for controlEvents: UIControl.Event = .primaryActionTriggered, action: @escaping () -> ()) {
    //        let sleeve = ClosureSleeve(attachTo: self, closure: action)
    //        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    //    }
    
    func block_setAction(block: @escaping BlockButtonActionBlock) {
        objc_setAssociatedObject(self, &ActionBlockKey, ActionBlockWrapper(block: block), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        addTarget(self, action: #selector(block_handleAction), for: .touchUpInside)
    }
    
    @objc func block_handleAction() {
        let wrapper = objc_getAssociatedObject(self, &ActionBlockKey) as! ActionBlockWrapper
        wrapper.block(self)
    }
}

var ActionBlockKey: UInt8 = 0

// a type for our action block closure
typealias BlockButtonActionBlock = (_ sender: UIControl) -> Void

class ActionBlockWrapper : NSObject {
    var block : BlockButtonActionBlock
    init(block: @escaping BlockButtonActionBlock) {
        self.block = block
    }
}


extension NSNumber {
    func toCurrency() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: self)!
    }
}


extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATransitionType(_ input: CATransitionType) -> String {
    return input.rawValue
}



//MARK:- Shadow Class
class shadowView: UIView {
    override func awakeFromNib() {
        // shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2.0
        super.awakeFromNib()
        
    }
}
// Definition:
extension Notification.Name {
    static let SEARCHNOTIFICATION = Notification.Name("SERACHNOTIFICATION")
}
