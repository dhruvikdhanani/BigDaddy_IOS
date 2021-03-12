//
//  Styleguide.swift
//
//  Created by Göksel Köksal on 18/06/16.
//  Copyright © 2016 Mangu. All rights reserved.
//

import UIKit

enum Color {
    static let black = UIColor.black
    static let tint = UIColor.green
}

enum Alpha {
    static let none     = CGFloat(0.0)
    static let veryLow  = CGFloat(0.05)
    static let low      = CGFloat(0.30)
    static let medium1  = CGFloat(0.40)
    static let medium2  = CGFloat(0.50)
    static let medium3  = CGFloat(0.60)
    static let high     = CGFloat(0.87)
    static let full     = CGFloat(1.0)
}

enum Font {
    static func withSize(_ size: CGFloat, weight: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight(rawValue: weight))
    }
}

extension TextStyle {
//    UIColor(hexString: "#30679F") Theme
//    UIColor(hexString: "#BCCEE0") Light Theme
    
    /// FONT :- Montserrat-Bold SIZE:- 20 COLOR themeFontColor
    static let HederBold = TextStyle(
        font:  UIFont.init(name: "Montserrat-Bold", size: 20.0) ?? Font.withSize(20, weight: UIFont.Weight.bold.rawValue),
        color: UIColor.themeFontColor )
    
    /// FONT :- Montserrat-Medium SIZE:- 16 COLOR themeFontColor
    static let textField = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 16.0) ?? Font.withSize(16, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.themeFontColor )
    
    /// FONT :- Montserrat-SemiBold SIZE:- 16 COLOR themeFontColor
    static let lblSemiBold = TextStyle(
        font:  UIFont.init(name: "Montserrat-SemiBold", size: 16.0) ?? Font.withSize(16, weight: UIFont.Weight.semibold.rawValue),
        color: UIColor.themeFontColor )
    
    /// FONT :- Montserrat-Medium SIZE:- 16 COLOR white
    static let textFieldWhite = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 16.0) ?? Font.withSize(16, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.white )
    
    /// FONT :- Montserrat-Medium SIZE:- 18 COLOR themeColor
    static let buttonTheme = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 18.0) ?? Font.withSize(18, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.themeColor)
    
    /// FONT :- Montserrat-Medium SIZE:- 18 COLOR themeFontColor
    static let buttonThemeFont = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 18.0) ?? Font.withSize(18, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.themeFontColor)
    
    /// FONT :- Montserrat-Medium SIZE:- 13 COLOR themeColor
    static let buttonThemeDetail = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 13.0) ?? Font.withSize(13, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.themeColor)
    
    /// FONT :- Montserrat-Medium SIZE:- 18 COLOR white
    static let buttonWhite = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 18.0) ?? Font.withSize(18, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.white)
    
    /// FONT :- Montserrat-Medium SIZE:- 16 COLOR white
    static let buttonWhiteMedium = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 16.0) ?? Font.withSize(16, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.white)
    
    /// FONT :- Montserrat-Medium SIZE:- 13 COLOR white
    static let buttonWhiteMedium13 = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 13.0) ?? Font.withSize(13, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.white)
    
    /// FONT :- Montserrat-Medium SIZE:- 11 COLOR white
    static let buttonWhiteMedium11 = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 11.0) ?? Font.withSize(11, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.white)
    
    /// FONT :- Montserrat-Regular SIZE:- 16 COLOR themeFontLightColor
    static let lblRegular = TextStyle(
        font:  UIFont.init(name: "Montserrat-Regular", size: 16.0) ?? Font.withSize(16, weight: UIFont.Weight.regular.rawValue),
        color: UIColor.themeFontLightColor)
    
    /// FONT :- Montserrat-Medium SIZE:- 11 COLOR themeFontColor
    static let lblMedium11 = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 11.0) ?? Font.withSize(11, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.themeFontColor)
    
    /// FONT :- Montserrat-Medium SIZE:- 12 COLOR themeFontColor
    static let lblMedium12 = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 12.0) ?? Font.withSize(12, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.themeFontColor)
    
    /// FONT :- Montserrat-Regular SIZE:- 10 COLOR themeFontLightColor
    static let lblRegular10 = TextStyle(
        font:  UIFont.init(name: "Montserrat-Regular", size: 10.0) ?? Font.withSize(10, weight: UIFont.Weight.regular.rawValue),
        color: UIColor.themeFontLightColor)
    
    /// FONT :- Montserrat-Light SIZE:- 16 COLOR themeFontLightColor
    static let lblLight = TextStyle(
        font:  UIFont.init(name: "Montserrat-Light", size: 16.0) ?? Font.withSize(16, weight: UIFont.Weight.light.rawValue),
        color: UIColor.themeFontLightColor)
    
    /// FONT :- Montserrat-Light SIZE:- 12 COLOR themeFontColor
    static let lblLight12 = TextStyle(
        font:  UIFont.init(name: "Montserrat-Light", size: 12.0) ?? Font.withSize(12, weight: UIFont.Weight.light.rawValue),
        color: UIColor.themeFontColor)
    
    /// FONT :- Montserrat-Light SIZE:- 12 COLOR yellow(FF9811)
    static let lblLight12Yellow = TextStyle(
        font:  UIFont.init(name: "Montserrat-Light", size: 12.0) ?? Font.withSize(12, weight: UIFont.Weight.light.rawValue),
        color: UIColor.init(hexString: "#FF9811"))
    
    /// FONT :- Montserrat-Light SIZE:- 12 COLOR GREEN
    static let lblLight12Green = TextStyle(
        font:  UIFont.init(name: "Montserrat-Light", size: 12.0) ?? Font.withSize(12, weight: UIFont.Weight.light.rawValue),
        color: UIColor.themeGreenColor)
    
    /// FONT :- Montserrat-Light SIZE:- 10 COLOR GREEN
    static let lblLight10Green = TextStyle(
        font:  UIFont.init(name: "Montserrat-Light", size: 10.0) ?? Font.withSize(10, weight: UIFont.Weight.light.rawValue),
        color: UIColor.themeGreenColor)
    
    /// FONT :- Montserrat-Light SIZE:- 12 COLOR RED
    static let lblLight12Red = TextStyle(
        font:  UIFont.init(name: "Montserrat-Light", size: 12.0) ?? Font.withSize(12, weight: UIFont.Weight.light.rawValue),
        color: UIColor.themeColor)
  
  /// FONT :- Montserrat-Light SIZE:- 10 COLOR themeFontLightColor
  static let lblLight10 = TextStyle(
      font:  UIFont.init(name: "Montserrat-Light", size: 10.0) ?? Font.withSize(10, weight: UIFont.Weight.light.rawValue),
      color: UIColor.themeFontLightColor)
    
    /// FONT :- Montserrat-Light SIZE:- 10 COLOR themeFontColor
    static let lblThemeLight10 = TextStyle(
        font:  UIFont.init(name: "Montserrat-Light", size: 10.0) ?? Font.withSize(10, weight: UIFont.Weight.light.rawValue),
        color: UIColor.themeFontColor)
    
    /// FONT :- Montserrat-Light SIZE:- 18 COLOR themeFontLightColor
    static let lblLight18 = TextStyle(
        font:  UIFont.init(name: "Montserrat-Light", size: 18.0) ?? Font.withSize(18, weight: UIFont.Weight.light.rawValue),
        color: UIColor.themeFontLightColor)
    
    /// FONT :- Montserrat-Regular SIZE:- 15 COLOR themeFontColor
    static let lblTheme = TextStyle(
        font:  UIFont.init(name: "Montserrat-Regular", size: 15.0) ?? Font.withSize(15, weight: UIFont.Weight.regular.rawValue),
        color: UIColor.themeFontColor)
    
    /// FONT :- Montserrat-Bold SIZE:- 15 COLOR themeFontColor
    static let lblBold = TextStyle(
        font:  UIFont.init(name: "Montserrat-Bold", size: 15.0) ?? Font.withSize(15, weight: UIFont.Weight.bold.rawValue),
        color: UIColor.themeFontColor)
    
    /// FONT :- Montserrat-Bold SIZE:- 24 COLOR themeFontColor
    static let lblBold24 = TextStyle(
        font:  UIFont.init(name: "Montserrat-Bold", size: 24.0) ?? Font.withSize(24, weight: UIFont.Weight.bold.rawValue),
        color: UIColor.themeFontColor)
    
    /// FONT :- Montserrat-Medium SIZE:- 13 COLOR themeColor
    static let btnThemeVerify = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 13.0) ?? Font.withSize(13, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.themeColor)
  
  /// FONT :- Montserrat-Medium SIZE:- 16 COLOR themeFontColor
  static let lblMedium16 = TextStyle(
      font:  UIFont.init(name: "Montserrat-Medium", size: 16.0) ?? Font.withSize(16, weight: UIFont.Weight.medium.rawValue),
      color: UIColor.themeFontColor)
    
    /// FONT :- Montserrat-Medium SIZE:- 16 COLOR YELLOW(FF9811)
    static let lblMedium16Yellow = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 16.0) ?? Font.withSize(16, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.init(hexString: "#FF9811"))
    
    /// FONT :- Montserrat-Medium SIZE:- 16 COLOR GREEN
    static let lblMedium16Green = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 16.0) ?? Font.withSize(16, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.themeGreenColor)
    
    /// FONT :- Montserrat-SemiBold SIZE:- 18 COLOR GREEN
    static let lblSemiBold18Green = TextStyle(
        font:  UIFont.init(name: "Montserrat-SemiBold", size: 18.0) ?? Font.withSize(18, weight: UIFont.Weight.semibold.rawValue),
        color: UIColor.themeGreenColor)
    
    /// FONT :- Montserrat-Medium SIZE:- 16 COLOR themeColor
    static let lblMedium16Red = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 16.0) ?? Font.withSize(16, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.themeColor)
    
    /// FONT :- Montserrat-Medium SIZE:- 11 COLOR 23a84c (RED STATUS)
    static let lblStatusColor = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 11.0) ?? Font.withSize(11, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.themeColor)
    
    /// FONT :- Montserrat-Medium SIZE:- 18 COLOR #FF928E
    static let btnDeleteAccount = TextStyle(
        font:  UIFont.init(name: "Montserrat-Medium", size: 18.0) ?? Font.withSize(18, weight: UIFont.Weight.medium.rawValue),
        color: UIColor.themeColor)
    
}

extension TextStyle {
    
    enum Button {
        static let action = TextStyle(
            font: Font.withSize(16.0, weight: UIFont.Weight.medium.rawValue),
            color: Color.tint
        )
    }
}
