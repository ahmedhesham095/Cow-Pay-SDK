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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    

    @IBAction func copyAction(_ sender: Any) {
        UIPasteboard.general.string = fawryCodeLabel.text
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
//        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
//        keyWindow?.dismiss()
    }
    
}
