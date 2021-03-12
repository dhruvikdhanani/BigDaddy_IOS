//
//  AppConfig.swift
//  Pickvery
//
//  Created by DREAMS on 29/09/20.
//

import Foundation
import CoreLocation


let APP_TITLE = "Bid Daddy"
let API_ROOT = "http://192.168.0.103/bigdaddy/public/api/"
//let API_ROOT = "http://ithru.hostappshere.co.in/api/"

class SharedModel:NSObject {
    
    class func setUserDetails(_ dict:typeAliasDictionary) {
        UserDefaults.standard.setValue(dict, forKey: "USER_DETAILS")
        UserDefaults.standard.synchronize()
    }
    
    class func getUserDetails() -> typeAliasDictionary {
        return UserDefaults.standard.dictionary(forKey: "USER_DETAILS") ?? typeAliasDictionary()
    }
    
     
    class func setToken(_ token:String) {
        UserDefaults.standard.setValue(token, forKey: "TOKEN")
        UserDefaults.standard.synchronize()
    }
    
    class func getToken() -> String {
        return UserDefaults.standard.string(forKey: "TOKEN") ?? ""
    }
    
    class func setFCMToken(_ token:String) {
        UserDefaults.standard.setValue(token, forKey: "FCMTOKEN")
        UserDefaults.standard.synchronize()
    }
    
    class func getFCMToken() -> String {
        return UserDefaults.standard.string(forKey: "FCMTOKEN") ?? ""
    }
    
  
    class func setIsLogin(_ status:Bool) {
        UserDefaults.standard.setValue(status, forKey: "IS_LOGIN")
        UserDefaults.standard.synchronize()
    }
    
    class func getIsLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: "IS_LOGIN")
    }
     
}

func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
    }

func getConvertedDateFormater(_ date: String, from:String, to:String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = from
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    if let date = dateFormatter.date(from: date) {
        dateFormatter.dateFormat = to
        dateFormatter.timeZone = TimeZone.current
        return  dateFormatter.string(from: date)
    }
    return ""
}

func setEqualToSuperView(subView:UIView) {
    if subView.superview != nil {
        subView.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
            attributes.forEach {
                NSLayoutConstraint(item: subView, attribute: $0, relatedBy: .equal, toItem: subView.superview, attribute: $0, multiplier: 1, constant: 0).isActive = true
            }
    } else {
        showAlertWithTitle(message: "Please add subview", type: .WARNING)
    }
}

func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double, completion: ((CLPlacemark)->Void)?)  {
    var center : CLLocationCoordinate2D = CLLocationCoordinate2D()

    let ceo: CLGeocoder = CLGeocoder()
    center.latitude = pdblLatitude
    center.longitude = pdblLongitude

    let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

    ceo.reverseGeocodeLocation(loc, completionHandler:
        {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]

            if pm.count > 0 {
                let pm = placemarks![0]
                print(pm.country)
                print(pm.locality)
                print(pm.subLocality)
                print(pm.thoroughfare)
                print(pm.postalCode)
                print(pm.subThoroughfare)
                var addressString : String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }

                print(addressString)
              completion!(pm)
          }
    })

}

extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}

func getCoordinate( addressString : String, completionHandler: @escaping (CLLocationCoordinate2D, NSError?) -> Void) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
        if error == nil {
            if let placemark = placemarks?[0] {
                let location = placemark.location!
                    
                completionHandler(location.coordinate, nil)
                return
            }
        }
            
        completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
    }
}

public enum ALERT_MESSAGE_TYPE: Int {
  case SUCCESS
  case FAILURE
  case WARNING
  case INFO
}


func showAlertWithTitle(message : String, type : ALERT_MESSAGE_TYPE) {
  
  if type == .SUCCESS {
    ISMessages.showCardAlert(withTitle: APP_TITLE  , message: message , duration: 2.0, hideOnSwipe: true, hideOnTap: true, alertType: ISAlertType.success, alertPosition: ISAlertPosition.top, didHide: nil)
  }
  
  if type == .FAILURE  {
    ISMessages.showCardAlert(withTitle: APP_TITLE , message: message , duration: 2.0, hideOnSwipe: true, hideOnTap: true, alertType: ISAlertType.error, alertPosition: ISAlertPosition.top, didHide: nil)
  }
  
  if type == .WARNING {
    ISMessages.showCardAlert(withTitle: APP_TITLE  , message: message , duration: 2.0, hideOnSwipe: true, hideOnTap: true, alertType: ISAlertType.warning, alertPosition: ISAlertPosition.top, didHide: nil)
  }
  
  if type == .INFO {
    ISMessages.showCardAlert(withTitle: APP_TITLE  , message: message , duration: 2.0, hideOnSwipe: true, hideOnTap: true, alertType: ISAlertType.info, alertPosition: ISAlertPosition.top, didHide: nil)
  }
}
