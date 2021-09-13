//
//  CowpaySDK.swift
//  CowPay-me-SDK
//
//  Created by ahmed bassiouny on 9/13/21.
//

import Foundation
 class CowpaySDK {
    
    internal static var token = ""
    internal static var merchantCode = ""
    internal static var haskey = ""
    internal static var enviroment = Enviroment.staging
    internal static var paymentInfo : PaymentInfo?
    
    public static func getUrl() -> String {
        
        if(enviroment == Enviroment.live){
        return "https://cowpay.me/api/v2/"
        }
        else {
        return "https://staging.cowpay.me/api/v2/"
        }
    }
    
}


public enum Enviroment {
    case staging
    case live
}
