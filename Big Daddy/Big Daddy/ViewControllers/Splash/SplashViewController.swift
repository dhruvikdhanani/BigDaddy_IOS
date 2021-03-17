//
//  SplashViewController.swift
//  Big Dady
//
//  Created by Dhruvik Dhanani on 10/03/21.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var splashBackGroundImageView: UIImageView!
    @IBOutlet weak var splashImageView: UIImageView!
    
    var counter:Int = 1
    var resendTime:Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resendTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.selectLanguage), userInfo: nil, repeats: true)
        splashImageView.rotate()
        UIView.animate(withDuration: 0.8) {[weak self] in
            self?.splashImageView.alpha = 1
            self?.splashImageView.animationZoom(scaleX: 1.25, y: 1.25)
        }
    }
    
    @objc  func selectLanguage() {
        if counter > 0 {
            counter -= 1
        } else {
            resendTime?.invalidate()
            UIView.animate(withDuration: 0.8) { [weak self] in
                self?.splashImageView.animationZoom(scaleX: 1, y: 1)
            } completion: { [weak self] (status) in
                self?.splashImageView.stopRotating()
                self?.navigateToWalkThrough()
            }
        }
    }
    
    func navigateToWalkThrough() {
        UIView.animate(withDuration: 1.5) { [weak self] in
            self?.splashImageView.alpha = 0
            self?.splashBackGroundImageView.alpha = 0
        } completion: { [weak self] (status) in
            let wt = WalkThroughViewController.init(nibName: "WalkThroughViewController", bundle: nil)
            let navigationController = UINavigationController(rootViewController: wt)
            self?.appDelegate().window?.rootViewController = navigationController
            self?.appDelegate().window?.makeKeyAndVisible()
        }
    }

}
