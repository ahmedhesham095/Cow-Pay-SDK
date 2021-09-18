//
//  ViewController.swift
//  CowPay-me-SDK
//
//  Created by Ahmed Hesham on 10/09/2021.
//

import UIKit

class CowPayInitializer {
    
    

    private var lang = "en"
    
    public func initSDK(token:String,merchantCode:String,haskey:String,enviroment:Enviroment,with lang: Language){
        CowpaySDK.token = token
        CowpaySDK.merchantCode = merchantCode
        CowpaySDK.haskey = haskey
        if (lang == Language.en){
        self.lang = "en"
        }else{
        self.lang = "ar"
        }
        CowpaySDK.enviroment = enviroment
    }
    
    public func launchSDKView(paymentInfo:PaymentInfo,callback : CowpayCallback , window : UIWindow) {
        CowpaySDK.callback = callback
        if(CowpaySDK.token.isEmpty || CowpaySDK.merchantCode.isEmpty || CowpaySDK.haskey.isEmpty){
            print("Can't Load SDK , should call initSDK")
        }else {
            CowpaySDK.paymentInfo = paymentInfo
            self.presentPayView(lang: lang , window: window)
        }
    }
    
    
    private func presentPayView(animated: Bool = true , lang: String , window: UIWindow) {
        LocalizationHelper.setCurrentLang(lang: lang)
        LocalizationHelper.reset(window: window)
    }
    
    


}
