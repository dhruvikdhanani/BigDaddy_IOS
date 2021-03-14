//
//  AppDelegate.swift
//  Big Daddy
//
//  Created by Technomads on 15/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var sideMenuViewController:AKSideMenu?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 20
        UITableView().noDataListioner()
        showSplash()
        return true
    }

    func showSplash() {
        let splash = SplashViewController.init(nibName: "SplashViewController", bundle: nil)
        window?.rootViewController = splash
        window?.makeKeyAndVisible()
    }
    
    func showLogin() {
        let signIn = SignInViewController.init(nibName: "SignInViewController", bundle: nil)
        let navigationController = AppNavigationViewController(rootViewController: signIn)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showDash() {
        self.window?.rootViewController = buildController()
        self.window?.makeKeyAndVisible()
    }
    
    private func buildController() -> UIViewController {

        let navigationController = AppNavigationViewController(rootViewController: OrderListViewController())

        sideMenuViewController = AKSideMenu(contentViewController: navigationController,
                                                leftMenuViewController: SideMenuViewController(),
                                                rightMenuViewController: nil)

        sideMenuViewController?.menuPreferredStatusBarStyle = .lightContent
        sideMenuViewController?.delegate = self
        sideMenuViewController?.contentViewShadowColor = .black
        sideMenuViewController?.contentViewShadowOffset = CGSize(width: 0, height: 0)
        sideMenuViewController?.contentViewShadowOpacity = 0.6
        sideMenuViewController?.contentViewShadowRadius = 12
        sideMenuViewController?.contentViewShadowEnabled = true
        return sideMenuViewController!
    }
}

extension AppDelegate: AKSideMenuDelegate {

    public func sideMenu(_ sideMenu: AKSideMenu, willShowMenuViewController menuViewController: UIViewController) {
    }

    public func sideMenu(_ sideMenu: AKSideMenu, didShowMenuViewController menuViewController: UIViewController) {
    }

    public func sideMenu(_ sideMenu: AKSideMenu, willHideMenuViewController menuViewController: UIViewController) {
    }

    public func sideMenu(_ sideMenu: AKSideMenu, didHideMenuViewController menuViewController: UIViewController) {
    }
}
