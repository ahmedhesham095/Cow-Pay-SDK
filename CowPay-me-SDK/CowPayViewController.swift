//
//  CowPayViewController.swift
//  CowPay-me-SDK
//
//  Created by Ahmed Hesham on 11/09/2021.
//

import UIKit

class CowPayViewController: UIViewController {

    @IBOutlet weak var creditCardView: UIView!
    @IBOutlet weak var fawryView: UIView!
    @IBOutlet weak var cashCollection: UIView!
    @IBOutlet weak var cashCollectionTitle: UILabel!
    @IBOutlet weak var fawryTitle: UILabel!
    @IBOutlet weak var creditCardTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItemTitle("Payment Method")
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "44225A")
        setupCreditCard(self)
    }

    @IBAction func setupCreditCard(_ sender: Any) {
        selectCreditCard()
        deselectFawry()
        deselectCashCollection()
    }
    
    @IBAction func setupCashCollection(_ sender: Any) {
        selectCashCollection()
        deselectCreditCard()
        deselectFawry()
    }
    
    @IBAction func setupFawry(_ sender: Any) {
        selectFawry()
        deselectCreditCard()
        deselectCashCollection()
    }
    
    func selectCreditCard() {
        creditCardView.borderColor =  UIColor(hexString: "44225A")
        creditCardTitle.textColor =  UIColor(hexString: "44225A")
    }
    
    func selectFawry() {
        fawryView.borderColor =  UIColor(hexString: "44225A")
        fawryTitle.textColor =  UIColor(hexString: "44225A")
    }
    
    func selectCashCollection() {
        cashCollection.borderColor =  UIColor(hexString: "44225A")
        cashCollectionTitle.textColor =  UIColor(hexString: "44225A")
    }
    
    func deselectCashCollection() {
        cashCollection.borderColor =  UIColor(hexString: "f6f6f6")
        cashCollectionTitle.textColor =  UIColor.black
    }
    
    func deselectCreditCard() {
        creditCardView.borderColor =  UIColor(hexString: "f6f6f6")
        creditCardTitle.textColor =  UIColor.black
    }
    
    func deselectFawry() {
        fawryView.borderColor = UIColor(hexString: "f6f6f6")
        fawryTitle.textColor =  UIColor.black
    }
    
   
    
    
}
