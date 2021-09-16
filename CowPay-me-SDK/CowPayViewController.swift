//
//  CowPayViewController.swift
//  CowPay-me-SDK
//
//  Created by Ahmed Hesham on 11/09/2021.
//

import UIKit
import WebKit


enum CardType {
    case credit
    case fawry
    case cashCollection
}

extension CowPayViewController :WKNavigationDelegate{
    
  
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        var result = [String:String]()
        print("bassiouny" )
        print( webView.url?.query)
        if let query = webView.url?.query{
        let arr = query.components(separatedBy: "&")
            for item in arr {
                let content = item.components(separatedBy: "=")
                let s = content[0]
                result[s] = content[1]
            }
            let ticket = result["ticketNumber"] ?? ""
            if(result["result"]?.uppercased() == "SUCCESS" || !(ticket.isEmpty)){
                showDialogue(with: true, text: "success".localized()){
                    CowpaySDK.callback?.successByCard(card: self.interactor.card)
                    self.navigationController?.dismiss(animated: true, completion: nil)
                }
             
            }else {
                CowpaySDK.callback?.error()
            }
        }
    }
    
    
}


class CowPayViewController: UIViewController   {
    
    let interactor = Interactor()
   
    
    private func launchWebView(token:String){
        
        webView.isHidden = false
      

        webView.load(URLRequest(url: URL(string:CowpaySDK.getUrlForm()+token)!))
        webView.navigationDelegate = self
        
        
    }
    

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
    
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    let expiryDatePicker = MonthYearPickerView()
    var expiryDateToolBar: UIToolbar?
    var selectedPaymentType: CardType?
    var cardNumber: String?
    var cardHolderName: String?
    var CVV: String?
    var expiryDateString: String?
    var selectectedCity: String?
    var cities = [   "Cairo".localized(),
                     "Giza".localized(), "Haram".localized(),
                     "Downtown Alex".localized(),
                     "Sahel".localized(),
                     "Behira".localized(),
                     "Dakahlia".localized(),
                     "El Kalioubia".localized(),
                     "Gharbia".localized(),
                     "Kafr Alsheikh".localized(),
                     "Monufia".localized(),
                     "Sharqia".localized(),
                     "Isamilia".localized(),
                     "Suez".localized(),
                     "Port Said".localized(),
                     "Damietta".localized(),
                     "Fayoum".localized(),
                     "Bani Suif".localized(),
                     "Asyut".localized(),
                     "Sohag".localized(),
                     "Menya".localized(),
                     "Qena".localized(),
                     "Aswan".localized(),
                     "Luxor".localized()]
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
        selectectedCity = "0"
        if LocalizationHelper.getCurrentLanguage() == "ar" {
            txtCardHolderName.textAlignment = .right
            txtCardHolderName.placeholder = "اسم صاحب البطاقه"
            txtCardNumber.textAlignment = .right
            txtCardNumber.placeholder = "رقم البطاقه"
            txtExpiry.textAlignment = .right
            txtExpiry.placeholder = "تاريخ الانتهاء"
            txtCVV.textAlignment = .right
            txtEmail.textAlignment  = .right
            txtEmail.placeholder = "البريد الالكتروني"
            txtAddress.textAlignment = .right
            txtAddress.placeholder = "العنوان"
            txtFloor.textAlignment = .right
            txtFloor.placeholder = "الدور"
            txtDistrict.textAlignment = .right
            txtDistrict.placeholder = "الحي"
            txtApartment.textAlignment = .right
            txtApartment.placeholder = "الشقة"
            txtName.placeholder = "الاسم"
            txtName.textAlignment = .right
            txtPhone.placeholder = "رقم الهاتف"
            txtPhone.textAlignment = .right
        }
        
        // ---------------------- Dialogue -------------------------------//
//        let completion = { print("Bassiouny test")}
//        let text = "Your order has been submitted successfully"
//        self.showDialogue(with: true, completion: completion, text: text)
        // ---------------------------------------------------------- //
        
        setUserInfo()
    }
    
    private func setUserInfo(){
        txtEmail.text = CowpaySDK.paymentInfo?.customerEmail
        txtName.text = CowpaySDK.paymentInfo?.customerName
        txtPhone.text = CowpaySDK.paymentInfo?.customerMobile
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
        let actionSheetController: UIAlertController = UIAlertController(title: "Select City".localized(), message: nil, preferredStyle: .actionSheet)
        self.cities.forEach({ (city) in
            let firstAction: UIAlertAction = UIAlertAction(title: city , style: .default) { action -> Void in
                self.lblGovernment.text = city
                self.selectectedCity = "\(self.cities.firstIndex(of: city) ?? 0)"
            }
            actionSheetController.addAction(firstAction)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel".localized(), style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelAction)
        actionSheetController.popoverPresentationController?.sourceView = self.view
        self.present(actionSheetController, animated: true , completion: nil)
    }
    
    private func startLoading(){
        btnConfirm.isHidden = true
        loadingIndicator.isHidden = false
    }
    
    private func stopLoading(){
        btnConfirm.isHidden = false
        loadingIndicator.isHidden = true
    }
    
    @IBAction func confirmPayment(_ sender: Any) {
        let date = expiryDateString?.components(separatedBy: "/")
    
        if selectedPaymentType == .credit {
            if expiryDateString == nil || txtCardNumber.text?.isEmpty == true || txtCVV.text?.isEmpty == true || txtCardHolderName.text?.isEmpty == true {
                AlertMessage(title: "", userMessage: "Please fill all the fields")
            } else {
                //- Credit Card data
                if txtCardNumber.text?.luhnCheck() == false || txtCardNumber.text?.isStringContainsOnlyNumbers() == false || txtCardNumber.text?.count ?? 0 < 12 {
                    AlertMessage(title: "", userMessage: "Invalid Card Number")
                    return
                }
                startLoading()
                
                interactor.sendCreaditCard(cardNumber: txtCardNumber.text ?? "", cardName: txtCardHolderName.text ?? "", month: date?[0] ?? "", year: date?[1] ?? "", cvv: txtCVV.text ?? ""){ data , erro in
                    self.stopLoading()
                    
                    if let token = data {
                        self.launchWebView(token:token)
                    }
                    
                    if let msg = erro {
                        self.AlertMessage(title: "error".localized(), userMessage: msg)
                    }
                }
            }
        }
        
        if selectedPaymentType == .fawry {
            startLoading()
            interactor.sendFawry(){ data , erro in
                self.stopLoading()
                if let msg = erro {
                    self.AlertMessage(title: "error".localized(), userMessage: msg)
                }
                if let obj = data {
                    // navigate to fawry screen
                    let fawryVC = UIStoryboard(name: "CowPay", bundle: nil).instantiateViewController(withIdentifier: "fawryVC") as! FawryViewController
                    fawryVC.fawry = obj
                    self.navigationController?.pushViewController(fawryVC, animated: true)
                }
            }
        }
        
        if selectedPaymentType == .cashCollection {
            
            if txtEmail.text?.isEmpty == false , txtAddress.text?.isEmpty == false , txtFloor.text?.isEmpty == false , txtDistrict.text?.isEmpty == false , txtApartment.text?.isEmpty == false , selectectedCity != nil , txtName.text?.isEmpty == false , txtPhone.text?.isEmpty == false {

                startLoading()
                interactor.sendCashCollection(name: txtName.text!,email: txtEmail.text!,phone: txtPhone.text!,address: txtAddress.text!,floor: txtFloor.text!,district: txtDistrict.text!,apartment: txtApartment.text!,index: Int(selectectedCity ?? "0") ?? 0){ data , erro in
                    self.stopLoading()
                    if let msg = erro {
                        self.AlertMessage(title: "error".localized(), userMessage: msg)
                  
                    }
                    
                    if let obj = data {
                        let dialogueVC = CowPayDialogueViewController()
                        dialogueVC.modalPresentationStyle = .overCurrentContext
                        dialogueVC.action = {
                            CowpaySDK.callback?.successByCashCollection(cashCollection: obj)
                            self.navigationController?.dismiss(animated: true, completion: nil)
                        }
                        self.present(dialogueVC, animated: true, completion: nil)
                    }
                }
            } else {
                if txtEmail.text?.isEmail == false {
                    AlertMessage(title: "", userMessage: "Please Fill a valid Email")
                    return
                }
              AlertMessage(title: "", userMessage: "Please Fill all the fields")
            }
        }
    }
    
    @IBOutlet weak var webView: WKWebView!

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

extension CowPayViewController {
    func showDialogue(with Success: Bool  , text: String, completion: @escaping () -> Void) {
        let dialogueVC = CowPayDialogueViewController()
        dialogueVC.modalPresentationStyle = .overCurrentContext
        if Success {
            dialogueVC.image = UIImage(named: "ic_success")
        } else {
            dialogueVC.image = UIImage(named: "ic_warning")
        }
        dialogueVC.titleText = text
        dialogueVC.action = completion
        self.present(dialogueVC, animated: true, completion: nil)
    }
}
