# Cow-Pay-SDK
an iOS SDK to integrate with cow pay payment gateway
## Installation steps 
### 1. Copy the framework into your project files 
### 2. Choose Embed without siging option 
<img width="882" alt="Screen Shot 2021-09-18 at 7 23 59 PM" src="https://user-images.githubusercontent.com/23611381/133897529-3bd6c660-3dec-496b-95a2-c94fdf208953.png">

add the following code in your viewDidLoad() Method
=
```swift
// create object from CowPayInitializer
let cowpaySDk = CowPayInitializer()
// set madatory attributes
// token
let token = "SDK Token"
// merchant code
let merchantCode = "Merchat Code"
// haskey
let haskey = "Hash Key"
// enviroment
let enviroment = Enviroment.staging // you can select you enviroment (live or staging)
// sdk language
let lang = Language.ar // you can set sdk language (ar or en)

//---------------- Initialize the SDK ---------------------//
cowpaySDk.initSDK(token: token,merchantCode: merchantCode,haskey: haskey,enviroment: enviroment,with: lang)

//---------------- Initialize Payemnt Info Object ---------------------//
let paymentInfo = PaymentInfo(merchantReferenceId: "Merchant Refrence Id", customerMerchantProfileId: "customer Merchant Profile Id", amount: "amount", description: "description", customerName: "Customer Name", customerEmail: "customer Email", customerMobile: "Customer Mobile")
```
### to present the payment view use the code snippet below 
### kindly note that you need to specify your app UI Window 
```swift
if let window = UIApplication.shared.windows.first {
    cowpaySDk.launchSDKView(paymentInfo: paymentInfo, callback: self, window: window)
}
```
## you can verify the payment status through the following methods in ###CowpayCallback protocol

```swift 
extension ViewController : CowpayCallback {
    
    func successByFawry(fawry: Fawry?) {
        
    }
    
    func successByCard(card: Card?) {
        
    }
    
    func error() {
        
    }
    
    func successByCashCollection(cashCollection: CashCollection?) {
        
    }
    
    func closeByUser() {
        
    }
}
```
