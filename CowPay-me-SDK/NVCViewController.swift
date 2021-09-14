//
//  NVCViewController.swift
//  CowPay-me-SDK
//
//  Created by ahmed bassiouny on 9/13/21.
//

import UIKit

class NVCViewController: UIViewController,CowpayCallback {
    
    func successByFawry(fawry: Fawry?) {
        print("call back")
        print(fawry?.cowpayReferenceId)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDljMGY3NDYxODZjMDBlYTU2YmUyMGRkNTQ5Mzc3ZjgyZTZlYmQ4NzBjZWJlNjYzOGMzODFlM2ZjYjE4OTZlNWNhYjY4NDllYzM0ZThiYzciLCJpYXQiOiIxNjI4NTQwNDkzLjcyMTQ4OCIsIm5iZiI6IjE2Mjg1NDA0OTMuNzIxNDk0IiwiZXhwIjoiMTY2MDA3NjQ5My43MDk0NzEiLCJzdWIiOiIxNyIsInNjb3BlcyI6W119.CSRzKNQ-rQ8PvO_ZQUO6d533P0YVInv9X86fMQBKqEMf_Lcsp1jSuVpW5Yzz9RGhU2Sozjby-QwNp8NhdtmTag"
        
        // create object from CowPayInitializer
        let cowpaySDk = CowPayInitializer()
        // set madatory attributes
        // token
        // merchant code
        // haskey
        // enviroment
        cowpaySDk.initSDK(token: token,merchantCode: "dev1212",haskey: "dev1212",enviroment: Enviroment.staging,with: "en")
        
        // create payment info object
        let paymentInfo = PaymentInfo(merchantReferenceId: getNumber(), customerMerchantProfileId: "15", amount: "1", description: "description from ios", customerName: "ahmed bassiouny", customerEmail: "customer@customer.com", customerMobile: "01234567890")
        
        // launch sdk with payment info object
        cowpaySDk.launchSDKView(paymentInfo: paymentInfo,callback: self)
      
    }
    

    func getNumber() -> String {
        return String(Int.random(in: 4545121 ... 454512146846852))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
