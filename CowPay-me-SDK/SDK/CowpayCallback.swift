//
//  CowpayCallback.swift
//  CowPay-me-SDK
//
//  Created by ahmed bassiouny on 9/14/21.
//

import Foundation

protocol CowpayCallback {
    func successByFawry(fawry:Fawry?)
    func successByCashCollection(cashCollection:CashCollection?)
}
