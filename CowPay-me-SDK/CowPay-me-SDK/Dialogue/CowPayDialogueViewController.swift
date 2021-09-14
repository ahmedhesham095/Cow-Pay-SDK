//
//  CowPayDialogueViewController.swift
//  CowPay-me-SDK
//
//  Created by Ahmed Hesham on 14/09/2021.
//

import UIKit

class CowPayDialogueViewController: UIViewController {

  var action: (() -> Void)?

    @IBOutlet weak var dialogueImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func okAction(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.action?()
        }
    }
    

}
