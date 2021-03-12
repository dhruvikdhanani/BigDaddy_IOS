//
//  WalkThroughViewController.swift
//  Big Daddy
//
//  Created by Technomads on 15/02/21.
//

import UIKit

class WalkThroughViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var topOfScrollingIndicator: NSLayoutConstraint!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    let pageControl = SCPageControlView()
    @IBOutlet weak var pageControlView: UIView!
    var dataViews:[typeAliasDictionary] = [typeAliasDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let dict1:typeAliasDictionary = ["image":"1.1","header":"Door To Door Service","subHeader":"Ship and track parcels and packages and learn about our express courier services!"]
        let dict2:typeAliasDictionary = ["image":"1.2","header":"Professional Service","subHeader":"Ship and track parcels and packages and learn about our express courier services!"]
        let dict3:typeAliasDictionary = ["image":"1.3","header":"Fully Digital Process Service","subHeader":"Ship and track parcels and packages and learn about our express courier services!"]
        dataViews.append(dict1)
        dataViews.append(dict2)
        dataViews.append(dict3)
        topOfScrollingIndicator.constant = screenWidth + 32
        pageControl.frame = pageControlView.bounds
        pageControl.scp_style = .SCNormal
        pageControl.set_view(Int(containerView.frame.width/screenWidth), current: 0, current_color: UIColor.themeFontColor)
        pageControlView.addSubview(pageControl)
        setEqualToSuperView(subView: pageControl)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for i in 0..<dataViews.count {
            let view:ScrollableView = UIView.fromNib()
            view.frame = CGRect(x: screenWidth*CGFloat(i), y: 0, width: screenWidth, height: containerView.frame.height)
            view.imageIndicator.image = UIImage(named: dataViews[i].valuForKeyString("image"))
            view.lblHeader.text = dataViews[i].valuForKeyString("header")
            view.lblSubHeader.text = dataViews[i].valuForKeyString("subHeader")
            containerView.addSubview(view)
        }
    }
   
    @IBAction func btnSkipAction(_ sender: UIButton) {
        let signIn = SignInViewController.init(nibName: "SignInViewController", bundle: nil)
        self.navigationController?.pushViewController(signIn, animated: true)
    }
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        if pageControl.currentOfPage == 0 {
            pageControl.currentOfPage += 1
            scrollView.setContentOffset(CGPoint(x: CGFloat(pageControl.currentOfPage)*screenWidth, y: 0), animated: true)
        } else if pageControl.currentOfPage == 1 {
            pageControl.currentOfPage += 1
            scrollView.setContentOffset(CGPoint(x: CGFloat(pageControl.currentOfPage)*screenWidth, y: 0), animated: true)
        } else if pageControl.currentOfPage == 2 {
            let signIn = SignInViewController.init(nibName: "SignInViewController", bundle: nil)
            self.navigationController?.pushViewController(signIn, animated: true)
        } else {
            let signIn = SignInViewController.init(nibName: "SignInViewController", bundle: nil)
            self.navigationController?.pushViewController(signIn, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.scroll_did(scrollView)
        pageControl.currentOfPage = Int(scrollView.contentOffset.x/screenWidth)
    }
}
