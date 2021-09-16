//
//  NVCViewController.swift
//  CowPay-me-SDK
//
//  Created by ahmed bassiouny on 9/13/21.
//

import UIKit

class NVCViewController: UIViewController, CowpayCallback {
    
    func successByCard(card: Card?) {
        print(card?.cowpayReferenceId)
    }
    
    func error() {
       
    }
    
    func successByCashCollection(cashCollection: CashCollection?) {
        print(cashCollection?.cowpayReferenceId)
    }
    
    
    func successByFawry(fawry: Fawry?) {
        print(fawry?.cowpayReferenceId)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // staging
        
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDljMGY3NDYxODZjMDBlYTU2YmUyMGRkNTQ5Mzc3ZjgyZTZlYmQ4NzBjZWJlNjYzOGMzODFlM2ZjYjE4OTZlNWNhYjY4NDllYzM0ZThiYzciLCJpYXQiOiIxNjI4NTQwNDkzLjcyMTQ4OCIsIm5iZiI6IjE2Mjg1NDA0OTMuNzIxNDk0IiwiZXhwIjoiMTY2MDA3NjQ5My43MDk0NzEiLCJzdWIiOiIxNyIsInNjb3BlcyI6W119.CSRzKNQ-rQ8PvO_ZQUO6d533P0YVInv9X86fMQBKqEMf_Lcsp1jSuVpW5Yzz9RGhU2Sozjby-QwNp8NhdtmTag"
        
//        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMzk5MmQ4OTI5ZmJhOWFmOWJkNDQxMTYwZjU1NjA4YzBhNDlmZmRlNTBmZTM3ZGE3OTVmODBlMjg2YzdkODMzYzQwYWEyZWQ4NzA3MTc4OWIiLCJpYXQiOiIxNjMwMzM4ODkzLjA1Mzc0MSIsIm5iZiI6IjE2MzAzMzg4OTMuMDUzNzQ1IiwiZXhwIjoiMTY2MTg3NDg5My4wNDYyODciLCJzdWIiOiIxNyIsInNjb3BlcyI6W119.avaatGs9gCoqy6qNdz1Q9N8_lFZNNO8TpYz1rokVEe1EXt0dX8j1FwwJNb-fJ8QJMU7DlvuINL62Cuj17Nuwsg"
        
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
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            cowpaySDk.launchSDKView(paymentInfo: paymentInfo, callback: self, window: window)
        }
      
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
