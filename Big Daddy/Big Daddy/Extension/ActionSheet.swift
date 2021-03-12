
import Foundation
import UIKit

let CANCEL_TITLE        = "Cancel".localized()

class AlertActionView : NSObject{
    /// SHOW Yes or No Popup
    ///
    /// - Parameters:
    ///   - title: pass title of alertVIew
    ///   - message: passmessage of alertview
    ///   - onSelection: deleget that retun selection
    internal func showYesNoAlertView (_ title:String ,message: String,onSelection: @escaping (_ title: String) -> Void){
        
        var allertitle:String? = title;
        if title.isEmpty{
            allertitle = nil;
        }
        let alertController = UIAlertController.init(title: allertitle, message: message, preferredStyle: UIAlertController.Style.alert)

        alertController.addAction(UIAlertAction.init(title: NSLocalizedString("Yes".localized(), comment: ""), style: UIAlertAction.Style.default) { (action) in
            onSelection(action.title!)
        })
        
        alertController.addAction(UIAlertAction.init(title: NSLocalizedString("No".localized(), comment: ""), style: UIAlertAction.Style.destructive) { (action) in
            onSelection(action.title!)
        })
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alertController, animated: true, completion: nil)
        }
    }
    
    /// SHOW Ok Popup
    ///
    /// - Parameters:
    ///   - title: pass title of alertVIew
    ///   - message: passmessage of alertview
    ///   - onSelection: deleget that retun selection
    internal func showOkAlertView (_ title:String ,message: String,onSelection: @escaping (_ title: String) -> Void){
        var allertitle:String? = title;
        if title.isEmpty{
            allertitle = nil;
        }
        let alertController = UIAlertController.init(title: allertitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction.init(title: NSLocalizedString("OK".localized(), comment: ""), style: UIAlertAction.Style.default) { (action) in
            onSelection(action.title!)
        })
    
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alertController, animated: true, completion: nil)
        }
    }

    /// show action sheet for selection
    ///
    /// - Parameters:
    ///   - title: passtitle
    ///   - message: pass message
    ///   - buttonTitle: pass button title as a string array
    ///   - isIncludeCancelButton: pass true false for show cancel button
    ///   - onSelection: delegate retun selected button title includeing cancel
    internal func showActionAlertView (_ title:String ,message: String,buttonTitle : [String],isIncludeCancelButton:Bool,onSelection: @escaping (_ title: String) -> Void){
        
        var allertitle:String? = title;
        if title.isEmpty{
            allertitle = nil;
        }
        let alertController = UIAlertController.init(title: allertitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        for i in 0..<buttonTitle.count {
            alertController.addAction(UIAlertAction.init(title: NSLocalizedString(buttonTitle[i], comment: ""), style: UIAlertAction.Style.default) { (action) in
                onSelection(action.title!)
            })
        }
        
        if isIncludeCancelButton {
            alertController.addAction(UIAlertAction.init(title: NSLocalizedString(CANCEL_TITLE, comment: ""), style: UIAlertAction.Style.cancel) { (action) in
                onSelection(action.title!)
            })
        }
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alertController, animated: true, completion: nil)
        }
    }
    
    
}
