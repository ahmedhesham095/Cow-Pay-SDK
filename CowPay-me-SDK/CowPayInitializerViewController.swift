//
//  ViewController.swift
//  CowPay-me-SDK
//
//  Created by Ahmed Hesham on 10/09/2021.
//

import UIKit

class CowPayInitializerViewController: UIViewController {
    var window: UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.launchSDKView(with: "en")
    }

    public func launchSDKView(with lang: String) {
        self.presentPayView(lang: lang)
    }
    
    
    func presentPayView(animated: Bool = true , lang: String) {
        LocalizationHelper.setCurrentLang(lang: lang)
        LocalizationHelper.reset()
    }



}
