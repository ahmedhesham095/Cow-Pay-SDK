//
//  PaymentInfo.swift
//  CowPay-me-SDK
//
//  Created by ahmed bassiouny on 9/13/21.
//

import Foundation

struct PaymentInfo :Encodable{
    var merchantReferenceId : String
    var customerMerchantProfileId : String
    var amount : String
    var description : String
    var customerName : String
    var customerEmail : String
    var customerMobile : String
}
