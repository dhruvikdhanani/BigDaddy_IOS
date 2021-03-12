

import UIKit
let shareKeyWindow = UIApplication.shared.keyWindow

class LoaderView: UIView {
    @IBOutlet var saveControll: NVActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        sendSubviewToBack(blurEffectView)
        saveControll.startAnimating()
    }
    func stopanimation(){
        saveControll.stopAnimating()
        saveControll.removeFromSuperview()   
    }
}

func showLoder(){
    
    if let window = shareKeyWindow ,window.viewWithTag(1231231231) == nil{
        // Do stuff
        let loderView: LoaderView = UIView.fromNib()
        loderView.frame = window.frame
        loderView.tag = 1231231231
        window.addSubview(loderView)
     }

}

func hideLoder(){
    if let window = shareKeyWindow ,window.viewWithTag(1231231231) != nil{
        let loderView: LoaderView = window.viewWithTag(1231231231) as! LoaderView
        loderView.stopanimation()
        loderView.removeFromSuperview()
    }
}
