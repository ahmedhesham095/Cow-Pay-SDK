//
//  CowPayViewController.swift
//  CowPay-me-SDK
//
//  Created by Ahmed Hesham on 11/09/2021.
//

import UIKit

enum CardType {
    case credit
    case fawry
    case cashCollection
}

class CowPayViewController: UIViewController {

    @IBOutlet weak var creditCardView: UIView!
    @IBOutlet weak var fawryView: UIView!
    @IBOutlet weak var cashCollection: UIView!
    @IBOutlet weak var cashCollectionTitle: UILabel!
    @IBOutlet weak var fawryTitle: UILabel!
    @IBOutlet weak var creditCardTitle: UILabel!
    @IBOutlet weak var txtCardHolderName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtExpiry: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var fawryLabel: UILabel!
    @IBOutlet weak var creditCardStack: UIStackView!
    @IBOutlet weak var cashCollectionStack: UIStackView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtFloor: UITextField!
    @IBOutlet weak var txtDistrict: UITextField!
    @IBOutlet weak var txtApartment: UITextField!
    @IBOutlet weak var lblGovernment: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    let expiryDatePicker = MonthYearPickerView()
    var expiryDateToolBar: UIToolbar?
    var selectedPaymentType: CardType?
    var cardNumber: String?
    var cardHolderName: String?
    var CVV: String?
    var expiryDateString: String?
    var selectectedCity: String?
    var cities = [   "Cairo",
                     "Giza", "Haram",
                     "Downtown Alex",
                     "Sahel",
                     "Behira",
                     "Dakahlia",
                     "El Kalioubia",
                     "Gharbia",
                     "Kafr Alsheikh",
                     "Monufia",
                     "Sharqia",
                     "Isamilia",
                     "Suez",
                     "Port Said",
                     "Damietta",
                     "Fayoum",
                     "Bani Suif",
                     "Asyut",
                     "Sohag",
                     "Menya",
                     "Qena",
                     "Aswan",
                     "Luxor"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItemTitle("Payment Method")
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "44225A")
        setupCreditCard(self)
        selectedPaymentType = .credit
        txtCardHolderName.delegate = self
        txtCardNumber.delegate = self
        txtCVV.delegate = self
        txtExpiry.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.expiryDateLabelTapped))
        txtExpiry.isUserInteractionEnabled = true
        txtExpiry.addGestureRecognizer(tapGesture)
    }

    @IBAction func setupCreditCard(_ sender: Any) {
        selectCreditCard()
        deselectFawry()
        deselectCashCollection()
        creditCardStack.isHidden = false
        fawryLabel.isHidden = true
        cashCollectionStack.isHidden = true
        selectedPaymentType = .credit
    }
    
    @IBAction func setupCashCollection(_ sender: Any) {
        selectCashCollection()
        deselectCreditCard()
        deselectFawry()
        fawryLabel.isHidden = true
        cashCollectionStack.isHidden = false
        creditCardStack.isHidden = true
        selectedPaymentType = .cashCollection
    }
    
    @IBAction func setupFawry(_ sender: Any) {
        selectFawry()
        deselectCreditCard()
        deselectCashCollection()
        creditCardStack.isHidden = true
        fawryLabel.isHidden = false
        cashCollectionStack.isHidden = true
        selectedPaymentType = .fawry
    }
    
    @IBAction func selectGovernmentAction(_ sender: Any) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Select City", message: nil, preferredStyle: .actionSheet)
        self.cities.forEach({ (city) in
            let firstAction: UIAlertAction = UIAlertAction(title: city , style: .default) { action -> Void in
                self.lblGovernment.text = city
                self.selectectedCity = "\(self.cities.index(of: city))"
            }
            actionSheetController.addAction(firstAction)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelAction)
        actionSheetController.popoverPresentationController?.sourceView = self.view
        self.present(actionSheetController, animated: true , completion: nil)
    }
    
    
    @IBAction func confirmPayment(_ sender: Any) {
        if selectedPaymentType == .credit {
            if expiryDateString == nil , txtCardNumber.text?.isEmpty == true , txtCVV.text?.isEmpty == true , txtCardHolderName.text?.isEmpty == true {
                AlertMessage(title: "", userMessage: "Please fill all the fields")
            } else {
                //- Credit Card data
                print("Bassiouny !!! \(cardNumber ?? "") \(expiryDateString ?? "") \(CVV ?? "") \(cardHolderName ?? "")")
            }
        }
        
        if selectedPaymentType == .fawry {
            // navigate to fawry screen
        }
        
        if selectedPaymentType == .cashCollection {
            
            if txtEmail.text?.isEmpty == false , txtAddress.text?.isEmpty == false , txtFloor.text?.isEmpty == false , txtDistrict.text?.isEmpty == false , txtApartment.text?.isEmpty == false , selectectedCity != nil , txtName.text?.isEmpty == false , txtPhone.text?.isEmpty == false {
                print("Bassiouny !!! \(txtEmail.text ?? "")  \(txtAddress.text ?? "") \(txtFloor.text ?? "") \(txtDistrict.text ?? "")  \(txtApartment.text ?? "") \(selectectedCity ?? "")")
            } else {
              AlertMessage(title: "", userMessage: "Please Fill all the fields")
            }
        }
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
//- Mark:// Validations
extension CowPayViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtCardNumber {
            if let txt = textField.text {
                if txt.count >= 13 && txt.isStringContainsOnlyNumbers() && txt.luhnCheck() {
                    cardNumber = textField.text
                } else {
                    AlertMessage(title: "", userMessage: "Invalid Card Number")
                }
            } else {
                AlertMessage(title: "", userMessage: "Please Enter a card Number")
            }
        }
        if textField == txtCardHolderName {
            if textField.text?.isEmpty == true {
                AlertMessage(title: "", userMessage: "Please Enter a card holder name")
            } else {
                cardHolderName = textField.text
            }
        }
        
        if textField == txtCVV {
            if textField.text?.isEmpty == true {
                AlertMessage(title: "", userMessage: "Please Enter an valid CVV")
            } else {
                CVV = textField.text
            }
        }
        
        if textField == txtEmail {
            if textField.text?.isEmail == false {
                AlertMessage(title: "", userMessage: "Please Enter an valid Email")
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // validate credit card datta
        if textField == txtCardNumber {
            let maxLength = 16
            let currentString: NSString = txtCardNumber.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        } else if  textField == txtCVV {
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        } else if textField == txtCardHolderName {
            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let Regex = "[a-z A-Z ]+"
            let predicate = NSPredicate.init(format: "SELF MATCHES %@", Regex)
            if predicate.evaluate(with: text) || string == ""
            {
                return true
            }
            else
            {
                return false
            }
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtExpiry {
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            for case let view as UIToolbar in self.view.subviews {
                view.removeFromSuperview()
            }
            for case let view as MonthYearPickerView in self.view.subviews {
                view.removeFromSuperview()
            }
        }
    }
    
}


extension CowPayViewController {
    
    @objc func expiryDateLabelTapped(sender:UITapGestureRecognizer) {
        self.pickADate()
    }
    
    private func pickADate() {
        txtCardNumber.resignFirstResponder()
        txtExpiry.resignFirstResponder()
        txtCardHolderName.resignFirstResponder()
        expiryDatePicker.backgroundColor = UIColor.white
        expiryDatePicker.setValue(UIColor.black, forKey: "textColor")
        expiryDatePicker.autoresizingMask = .flexibleWidth
        expiryDatePicker.contentMode = .center
        expiryDatePicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(expiryDatePicker)
        
        expiryDateToolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        expiryDateToolBar?.barStyle = .default
        expiryDateToolBar?.isTranslucent = true
        let doneButton = UIBarButtonItem(title: "Done".localized(), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didPressExpiryDone))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel".localized(), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didPressExpiryCancel))
        
        expiryDateToolBar?.setItems([cancelButton, spaceButton, doneButton], animated: false)
        expiryDateToolBar?.isUserInteractionEnabled = true
        DispatchQueue.main.async {
            self.view.addSubview(self.expiryDateToolBar ?? UIToolbar())
        }
        expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
            let expiryString = String(format: "%02d/%02d", month , (year % 100) )
            self.expiryDateString = expiryString
        }
    }
        @objc func didPressExpiryDone() {
            DispatchQueue.main.async {
                for case let view as UIToolbar in self.view.subviews {
                    view.removeFromSuperview()
                }
                for case let view as MonthYearPickerView in self.view.subviews {
                    view.removeFromSuperview()
                }
            }
            
            if expiryDateString == nil  {
                let year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
                let month = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
                expiryDateString = String(format: "%02d/%02d", month , (year % 100) )
            }
            txtExpiry.text = expiryDateString
        }
    
        @objc func didPressExpiryCancel() {
            DispatchQueue.main.async {
                for case let view as UIToolbar in self.view.subviews {
                    view.removeFromSuperview()
                }
                for case let view as MonthYearPickerView in self.view.subviews {
                    view.removeFromSuperview()
                }
            }
        }
    }
