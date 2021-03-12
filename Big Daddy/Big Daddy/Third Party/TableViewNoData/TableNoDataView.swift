
import UIKit
let TableNoDataViewLABELTAG = 3899271
let TableNoDataViewIMAGETAG = 3899272

/*
 Please use this coding in you appdelegate class to enable automatic
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 UITableView().noDataListioner()
 return true
 }
 
 */

/// use UITableView().noDataListioner() in appdelegate click here for more details 
class TableNoDataView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.TableViewLableWithTag(TableNoDataViewLABELTAG).style(style: TextStyle.lblSemiBold)
    }
}

//LOGIC FOR ADD NO DATA VIEW IN ALL ARE GOES HERE

extension UIView{
    class func TableViewfromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func TableViewLableWithTag(_ tag:Int) -> UILabel {
        if let lable = self.viewWithTag(tag){
            return lable as! UILabel
        }
        return  UILabel()
    }
    func TableViewImageViewWithTag(_ tag:Int) -> UIImageView {
        if let lable = self.viewWithTag(tag){
            return lable as! UIImageView
        }
        return  UIImageView()
    }
    
}

extension UITableView {
    
    
    @objc func swizzled_ReloadData() {
        
        swizzled_ReloadData()
        
        if self.showNoDataView{
            if  let method = self.dataSource?.numberOfSections?(in: self){
                if method > 0{
                    if  let count = self.dataSource?.tableView(self, numberOfRowsInSection: 0){
                        if count > 0{
                            //SOME DATA FOUND PLEASE HIDE THE VIEW OF NO DATA FOUND THANKS FOR READ
                            self.backgroundView = nil
                            
                        }else{
                            
                            let holdSuccessView: TableNoDataView = UIView.TableViewfromNib()
                            holdSuccessView.frame  = self.bounds
                            self.backgroundView = holdSuccessView
                            
                            self.TableViewLableWithTag(TableNoDataViewLABELTAG).text = self.noDataMessage
                            self.TableViewImageViewWithTag(TableNoDataViewIMAGETAG).image = self.noDataImage
                            print("THERE IS NO DATA FOUND")
                            
                        }
                    }
                }else{
                    
                    let holdSuccessView: TableNoDataView = UIView.TableViewfromNib()
                    holdSuccessView.frame  = self.bounds
                    self.backgroundView = holdSuccessView
                    self.TableViewLableWithTag(TableNoDataViewLABELTAG).text = self.noDataMessage
                    self.TableViewImageViewWithTag(TableNoDataViewIMAGETAG).image = self.noDataImage
                    print("THERE IS NO DATA FOUND")
                    
                    
                }
                
            }
        }else{
            print("NOT DATA DISABLE")
            
        }
        
    }
    @IBInspectable var showNoDataView:Bool {
        set {
            self.layer.setValue(newValue, forKey: "ISSHOWNODATA")
        }
        get {
            if let message : Bool = self.layer.value(forKey:"ISSHOWNODATA") as? Bool {
                return message
            }else{
                return false
            }
        }
    }
    
    @IBInspectable var noDataMessage:String {
        set {
            self.layer.setValue(newValue, forKey: "NODATAMESSAGE")
        }
        get {
            if let message : String = self.layer.value(forKey:"NODATAMESSAGE") as? String {
                return message
            }else{
                return "No Rows To Show"
            }
        }
        
    }
    
    
    @IBInspectable var noDataImage: UIImage? {
        set {
            self.layer.setValue(newValue, forKey: "NODATAImage")
        }
        get {
            if let image : UIImage = (self.layer.value(forKey:"NODATAImage") as? UIImage) {
                return image
            }
            return UIImage()
        }
    }
    
    func noDataListioner(){
        let originalSelector = #selector(reloadData)
        let swizzledSelector = #selector(swizzled_ReloadData)
        
        //        let new = class_getInstanceMethod(UITableView.self, originalSelector)!
        //        let old = class_getClassMethod(UITableView.self, originalSelector)
        //        if new == old{
        //            print("EQUAL \n\n")
        //        }else{
        //            print("NOT EQAL \n\n")
        //        }
        self.TableSwizzling(originalSelector, with: swizzledSelector)
    }
    
    func TableSwizzling(_ oldSelector: Selector, with newSelector: Selector) {
        let oldMethod = class_getInstanceMethod(UITableView.self, oldSelector)!
        let newMethod = class_getInstanceMethod(UITableView.self, newSelector)!
        let oldImplementation = method_getImplementation(oldMethod)
        let newImplementation = method_getImplementation(newMethod)
        _ = method_setImplementation(oldMethod, newImplementation)
        _ = method_setImplementation(newMethod, oldImplementation)
        
    }
}



