//
//  AppDelegate.swift
//  CowPay-me-SDK
//
//  Created by Ahmed Hesham on 10/09/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

}

extension AppDelegate {
    class var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func resetRootWithCowPayView(animated: Bool = true , window: UIWindow) {
        let cowPayStoryBoard = UIStoryboard(name: "CowPay", bundle: nil)
        let cowPayNavigation = cowPayStoryBoard.instantiateViewController(withIdentifier: "paymentView") as! UINavigationController 
        self.setRoot(withController: cowPayNavigation, animated: animated, window: window)
    }
    
    func setRoot(withController viewController: UIViewController,
                 animated: Bool = true , window: UIWindow) {
//        guard let window = window else {
//            return
//        }
        DispatchQueue.main.async {
            viewController.modalPresentationStyle = .fullScreen
            window.rootViewController?.present(viewController, animated: true, completion: nil)
        }
        if animated {
            UIView.transition(with: window, duration: 0.6, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
