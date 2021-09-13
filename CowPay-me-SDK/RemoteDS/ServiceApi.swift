//
//  ServiceApi.swift
//  CowPay-me-SDK
//
//  Created by ahmed bassiouny on 9/13/21.
//

import Foundation
import Alamofire

public class ServiceApi {
    
    static func sendCreditCard(json:Dictionary<String,String>){
        let encoder = JSONParameterEncoder.prettyPrinted
        AF.request(CowpaySDK.getUrl()+"charge/card/direct", method: .post, parameters: json,encoder:encoder,headers:headers()).responseJSON{  response in
            
            switch response.result {
                      case .success(let value):
                          if let json = value as? [String: Any] {
                              print(json)
                          }
                      case .failure(let error):
                          print(error)
                      }
            

        }
    }
    
    static func sendCashCollectino(json:Dictionary<String,String>){
        let encoder = JSONParameterEncoder.prettyPrinted
        AF.request("https://cowpay.me/api/v2/charge/cash-collection", method: .post, parameters: json,encoder:encoder,headers:headers()).responseJSON{  response in
            
            switch response.result {
                      case .success(let value):
                          if let json = value as? [String: Any] {
                              print(json)
                          }
                      case .failure(let err):
                        //error(err.localizedDescription)
            print(err)
                      }
            

        }
    }
    
    static func sendFawry(json:Dictionary<String,String>){
        let encoder = JSONParameterEncoder.prettyPrinted
        AF.request(CowpaySDK.getUrl()+"charge/fawry", method: .post, parameters: json,encoder:encoder,headers:headers()).responseJSON{  response in
            
            switch response.result {
                      case .success(let value):
                          if let json = value as? [String: Any] {
                              print(json)
                          }
                      case .failure(let error):
                          print(error)
                      }
            

        }
    }
    
    static func headers() -> HTTPHeaders
    {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization":"Bearer "+CowpaySDK.token
        ]
        
        return headers
    }
}


