
//let defaultFont = "Kefa-Regular"
//let defaultFontMedium = "Kefa-Medium"
//let defaultFontBold = "Kefa-Bold"

import UIKit

typealias typeAliasDictionary               = [String: Any]
typealias typeAliasStringDictionary         = [String: String]

#if DEBUG
func dLog(message: Any, filename: String = #file, function: String = #function, line: Int = #line) {
  print("%@","[\((filename as NSString).lastPathComponent):\(line)] \(function) - \(message)")
}
#else
func dLog(message: Any, filename: String = #file, function: String = #function, line: Int = #line) {
}
#endif

// Screen width.
public var screenWidth: CGFloat {
  return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
  return UIScreen.main.bounds.height
}

public func getHeight(Percentage:Float) -> Float{
  return Float(UIScreen.main.bounds.height) * Percentage / 100
}

public func getWidth(Percentage:Float) -> Float{
  return Float(UIScreen.main.bounds.width) * Percentage / 100
}

public func getHeight(Percentage:Float,View:UIView) -> Float{
  return Float(View.bounds.height) * Percentage / 100
}

public func getWidth(Percentage:Float,View:UIView) -> Float{
  return Float(View.bounds.width) * Percentage / 100
}

extension UITextField{
  //placeholder color
  @IBInspectable var placeHolderColor: UIColor? {
    get {
      return self.placeHolderColor
    }
    set {
      self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
    }
  }
  
  @IBInspectable var paddingLeftCustom: CGFloat {
    get {
      return leftView!.frame.size.width
    }
    set {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
      leftView = paddingView
      leftViewMode = .always
    }
  }
  
  @IBInspectable var paddingRightCustom: CGFloat {
    get {
      return rightView!.frame.size.width
    }
    set {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
      rightView = paddingView
      rightViewMode = .always
    }
  }
} 
/*
extension UILabel{
  
  override open func awakeFromNib() {
    self.font = UIFont(name: fontName, size: fontSize)
  }
  
  @IBInspectable var fontSize:CGFloat{
    get{
      return self.font.pointSize
    }
    set{
      self.font = UIFont(name: fontName, size: newValue)
    }
  }
  
  @IBInspectable var fontName: String {
    get {
      if self.font.fontName == ".SFUI-Regular"  {
        return defaultFont
      } else if self.font.fontName == ".SFUI-Bold" {
        return defaultFontBold
      } else if self.font.fontName == ".SFUI-Medium" {
        return defaultFontMedium
      }
      else{
        return self.font.fontName
      }
    }
    set {
      if self.font.fontName == ".SFUI-Bold" || self.font.fontName == ".SFUI-Regular" ||  self.font.fontName == ".SFUI-Medium"  {
        
        self.font = UIFont(name: newValue, size: fontSize)
      }
      else{
        self.font = UIFont(name: defaultFont, size: self.font.pointSize)
      }
    }
  }
  
  @IBInspectable var Textcolor: String{
    get{
      return self.textColor!.toHexString()
    }
    set{
      var cString:String = newValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
      }
      
      var rgbValue:UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)
      
      self.textColor = UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1)
    }
  }
  
  @IBInspectable var BackGroundColor: String{
    get{
      return self.backgroundColor!.toHexString()
    }
    set{
      var cString:String = newValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
      }
      
      var rgbValue:UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)
      
      self.backgroundColor = UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1)
    }
  }
}*/
/*
extension UITextField{
  
  @IBInspectable var fontSize:CGFloat{
    get{
      return self.font!.pointSize
    }
    set{
      self.font = UIFont(name: fontName, size: newValue)
    }
  }
  
  @IBInspectable var fontName: String {
    get {
      if self.font?.fontName == ".SFUI-Regular"  {
        return defaultFont
      } else if self.font?.fontName == ".SFUI-Bold" {
        return defaultFontBold
      } else if self.font?.fontName == ".SFUI-Medium" {
        return defaultFontMedium
      }
      else{
        return self.font!.fontName
      }
    }
    set {
      if self.font!.fontName == ".SFUI-Bold" || self.font!.fontName == ".SFUI-Regular" ||  self.font!.fontName == ".SFUI-Medium" {
        
        self.font = UIFont(name: newValue, size: fontSize)
      }
      else{
        self.font = UIFont(name: defaultFont, size: self.font!.pointSize)
      }
    }
  }
  
  @IBInspectable var Textcolor: String{
    get{
      return self.textColor!.toHexString()
    }
    set{
      var cString:String = newValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
      }
      
      var rgbValue:UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)
      
      self.textColor = UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1)
    }
  }
  
  @IBInspectable var BackGroundColor: String{
    get{
      return self.backgroundColor!.toHexString()
    }
    set{
      var cString:String = newValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
      }
      
      var rgbValue:UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)
      
      self.backgroundColor = UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1)
    }
  }
} */
/*
extension UIButton{
  @IBInspectable var fontSize:CGFloat{
    get{
      return self.titleLabel!.font.pointSize
    }
    set{
      self.titleLabel!.font = UIFont(name: fontName, size: newValue)
    }
  }
  
  @IBInspectable var fontName: String {
    get {
      if self.titleLabel?.font?.fontName == ".SFUI-Regular"  {
        return defaultFont
      } else if self.titleLabel?.font?.fontName == ".SFUI-Bold" {
        return defaultFontBold
      } else if self.titleLabel?.font?.fontName == ".SFUI-Medium" {
        return defaultFontMedium
      }
      else{
        return self.titleLabel!.font.fontName
      }
    }
    set {
      if self.titleLabel!.font.fontName == ".SFUI-Bold" || self.titleLabel!.font.fontName == ".SFUI-Regular" || self.titleLabel!.font.fontName == ".SFUI-Medium"  {
        
        self.titleLabel!.font = UIFont(name: newValue, size: fontSize)
      }
      else{
        self.titleLabel!.font = UIFont(name: defaultFont, size: self.titleLabel!.font.pointSize)
      }
    }
  }
  
  @IBInspectable var Textcolor: String{
    get{
      return (self.titleColor(for: .normal)?.toHexString())!
    }
    set{
      var cString:String = newValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
      }
      
      var rgbValue:UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)
      
      self.setTitleColor(UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1), for: .normal)
    }
  }
  
  @IBInspectable var BackGroundColor: String{
    get{
      return self.backgroundColor!.toHexString()
    }
    set{
      var cString:String = newValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
      }
      
      var rgbValue:UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)
      
      self.backgroundColor = UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1)
    }
  }
} */

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
  let size = image.size
  
  let widthRatio  = targetSize.width  / size.width
  let heightRatio = targetSize.height / size.height
  var newSize: CGSize
  if(widthRatio > heightRatio) {
    newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
  } else {
    newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
  }
  let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
  UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
  image.draw(in: rect)
  let newImage = UIGraphicsGetImageFromCurrentImageContext()
  return newImage!
}

extension UIImage {
  
  public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
    let radiansToDegrees: (CGFloat) -> CGFloat = {
      return $0 * (180.0 / CGFloat.pi)
    }
    let degreesToRadians: (CGFloat) -> CGFloat = {
      return $0 / 180.0 * CGFloat.pi
    }
    
    // calculate the size of the rotated view's containing box for our drawing space
    let rotatedViewBox = UIView(frame: CGRect(origin: .zero, size: size))
    let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
    rotatedViewBox.transform = t
    let rotatedSize = rotatedViewBox.frame.size
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize)
    let bitmap = UIGraphicsGetCurrentContext()
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    bitmap?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
    
    //   // Rotate the image context
    bitmap?.rotate(by: degreesToRadians(degrees))
    
    // Now, draw the rotated/scaled image into the context
    var yFlip: CGFloat
    
    if(flip){
      yFlip = CGFloat(-1.0)
    } else {
      yFlip = CGFloat(1.0)
    }
    
    bitmap?.scaleBy(x: yFlip, y: -1.0)
    let rect = CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height)
    
    bitmap?.draw(cgImage!, in: rect)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
}


extension UIImageView {
    
    enum ImageAddingMode {
        case changeOriginalImage
        case addSubview
    }
    
    func drawOnCurrentImage(anotherImage: UIImage?, mode: ImageAddingMode, rectCalculation: UIImage.RectCalculationClosure) {
        
        var image = UIImage()
        switch mode {
        case .changeOriginalImage:
            image = image.with(image: anotherImage, rectCalculation: rectCalculation)
        case .addSubview:
            let newImageView = UIImageView(frame: rectCalculation(frame.size, image.size))
            newImageView.image = anotherImage
            addSubview(newImageView)
            
        }
    }
}

extension UIImage {
    typealias RectCalculationClosure = (_ parentSize: CGSize, _ newImageSize: CGSize)->(CGRect)
    func with(image named: String, rectCalculation: RectCalculationClosure) -> UIImage {
        return with(image: UIImage(named: named), rectCalculation: rectCalculation)
    }
    
    func with(image: UIImage?, rectCalculation: RectCalculationClosure) -> UIImage {
        
        if let image = image {
            UIGraphicsBeginImageContext(size)
            
            draw(in: CGRect(origin: .zero, size: size))
            image.draw(in: rectCalculation(size, image.size))
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        }
        return self
    }
    
    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 10.0, height: 10.0)).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image.imageWithColor(color: .themeColor)
    }
    
    func image(byDrawingImage image: UIImage, inRect rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image.draw(in: rect)
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
}
