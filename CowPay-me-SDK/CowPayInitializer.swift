//
//  ViewController.swift
//  CowPay-me-SDK
//
//  Created by Ahmed Hesham on 10/09/2021.
//

import UIKit

class CowPayInitializer {
    
    

    private var lang = "en"
    
    public func initSDK(token:String,merchantCode:String,haskey:String,enviroment:Enviroment,with lang: String){
        CowpaySDK.token = token
        CowpaySDK.merchantCode = merchantCode
        CowpaySDK.haskey = haskey
        self.lang = lang
        CowpaySDK.enviroment = enviroment
    }
    
    public func launchSDKView(paymentInfo:PaymentInfo , window: UIWindow) {
        
        if(CowpaySDK.token.isEmpty || CowpaySDK.merchantCode.isEmpty || CowpaySDK.haskey.isEmpty){
            print("Can't Load SDK , should call initSDK")
        }else {
            CowpaySDK.paymentInfo = paymentInfo
            self.presentPayView(lang: lang , window: window)
            Interactor().sendCreaditCard(cardNumber: "5123450000000008",cardName: "ahmed",month: "05",year: "26",cvv: "123")
        }
    }
    
    
    private func presentPayView(animated: Bool = true , lang: String , window: UIWindow) {
        LocalizationHelper.setCurrentLang(lang: lang)
        LocalizationHelper.reset(window: window)
    }
    
    


}
