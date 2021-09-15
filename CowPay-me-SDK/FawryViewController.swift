//
//  FawryViewController.swift
//  CowPay-me-SDK
//
//  Created by Ahmed Hesham on 14/09/2021.
//

import UIKit

class FawryViewController: UIViewController {
    
    @IBOutlet weak var fawryCodeLabel: UILabel!
    @IBOutlet weak var fawryCodeDetailLabel: UILabel!
    var fawry:Fawry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        if let code = fawry?.paymentGatewayReferenceId{
            fawryCodeLabel.text = code
            fawryCodeDetailLabel.text = code
        }
    }
    

    @IBAction func copyAction(_ sender: Any) {
        UIPasteboard.general.string = fawryCodeLabel.text
        AlertMessage(title: "", userMessage: "copied".localized())
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        CowpaySDK.callback?.successByFawry(fawry: fawry)
        self.navigationController?.dismiss(animated: true, completion: nil)
//        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
//        keyWindow?.dismiss()
    }
    
}
