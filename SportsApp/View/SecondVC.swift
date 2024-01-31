//
//  SecondVC.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 13/09/2023.
//

import UIKit
import AcceptSDK
import WebKit

class SecondVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, WKNavigationDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var matchTF: UITextField!
    @IBOutlet weak var ticketCategoryTF: UITextField!
    @IBOutlet weak var numberOfTicketsTF: UITextField!
    
    var array = ["PL","laliga","CL","PL","laliga","CL","PL","laliga","CL","PL","laliga","CL","PL","laliga","CL"]
    
    let networkLayer = NetworkLayer()
    
    let accept = AcceptSDK()
    
    var firstToken: String = ""
    var orderID: Int = 0
    var paymentToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        accept.delegate = self
        getFirstToken()
        
        
        // Retrieve the stored launch date from UserDefaults
        if let launchDate = UserDefaults.standard.value(forKey: "appLaunchDate") as? Date {
            // Format the date as needed (e.g., "dd/MM/yyyy HH:mm:ss")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedLaunchDate = dateFormatter.string(from: launchDate)
            
            for i in 0..<10 {
                if let nextDate = Calendar.current.date(byAdding: .day, value: i, to: launchDate) {
                    let formattedNextDate = dateFormatter.string(from: nextDate)
                    //dateLabel.text?.append("\(formattedNextDate)\n")
                    print("\(formattedNextDate)\n")
                }
            }
            
            // Update the label with the formatted launch date
            dateLabel.text = "\(formattedLaunchDate)"
        } else {
            dateLabel.text = "Launch date unavailable"
        }
        
    }
    
    
    @IBAction func btn(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func button(_ sender: UIButton) {
//        let queue = DispatchQueue(label: "com.atrees.mahmoud")
//        queue.sync {
//            getOrderId()
//        }
//        queue.sync {
//            getPaymentToken()
//        }
        getPaymentToken()
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        print("btn pressed")
//        let queue = DispatchQueue(label: "com.atrees.mahmoud")
//        queue.sync {
//            getOrderId()
//        }
//        queue.sync {
//            getPaymentToken()
//        }
        if let url = URL(string: "https://accept.paymob.com/api/acceptance/iframes/794773?payment_token=\(paymentToken)") {
            let webViewController = WebViewController()
            webViewController.url = url
            navigationController?.pushViewController(webViewController, animated: true)
        }
    }
    
    @IBAction func thirdButton(_ sender: UIButton) {
        getOrderId()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! LeagueCollectionCell
        return cell
    }
    
}

extension SecondVC: AcceptSDKDelegate{
    
    func payVC(){
        do {
                   try accept.presentPayVC(vC: self, paymentKey: paymentToken, saveCardDefault:
                   true, showSaveCard: true, showAlerts: true)
               } catch AcceptSDKError.MissingArgumentError(let errorMessage) {
                   print(errorMessage)
               }  catch let error {
                   print(error.localizedDescription)
               }
    }
    
    func userDidCancel() {
        print("user canceled")
    }

    func paymentAttemptFailed(_ error: AcceptSDKError, detailedDescription: String) {
        print(error)
    }

    func transactionRejected(_ payData: PayResponse) {
        print(payData)
    }

    func transactionAccepted(_ payData: PayResponse) {
        print(payData)
    }

    func transactionAccepted(_ payData: PayResponse, savedCardData: SaveCardResponse) {
        print(payData)
    }

    func userDidCancel3dSecurePayment(_ pendingPayData: PayResponse) {
        print(pendingPayData.integration_id)
    }


}

extension SecondVC{
    func getFirstToken(){
        let apiUrl = URL(string: "https://accept.paymob.com/api/auth/tokens")!
        let body: [String: Any] = [
            "api_key": "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RJME5qVTNMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuSG9PNkZFUTZqUE1rOGxTSEhpdWxtczJiOXR6TkZBREtrSE1tdGxYanRVaGpMdEJBNFo0U3lfVW1PUlAzU1MyV2FmMmFMVnlKOHIxenhQTjdnZDBfZEE="
        ]
        
        networkLayer.sendPostRequest(apiURL: apiUrl, body: body) { result in
            switch result {
            case .success(let data):
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let accessToken = json["token"] as? String {
                        print("Token:", accessToken)
                        self.firstToken = accessToken
                        
                    } else {
                        print("Failed to extract token from the response")
                    }
                } catch {
                    print("Error parsing JSON:", error.localizedDescription)
                }
            case .failure(let error):
                // Handle error
                print("Error:", error.localizedDescription)
            }
        }
    }
    
    func getOrderId(){
        let apiUrl = URL(string: "https://accept.paymob.com/api/ecommerce/orders")!
        let items: [[String: Any]] = [
            [
                "name": matchTF.text ?? "",
                "amount_cents": "900000",
                "Ticket_Category": ticketCategoryTF.text ?? "",
                "quantity": numberOfTicketsTF.text ?? ""
            ],
            [
                "name": "Liverpool VS Real",
                "amount_cents": "200000",
                "Ticket_Category": "Gold",
                "quantity": "1"
            ]
        ]
        
        let body: [String: Any] = [
            "auth_token": "\(firstToken)",
            "delivery_needed": "false",
            "amount_cents": "10000",
            "currency": "EGP",
            "items": items
        ]
        networkLayer.sendPostRequest(apiURL: apiUrl, body: body) { result in
            switch result {
            case .success(let data):
                // Handle successful response (data contains the response data)
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let orderId = json["id"] as? Int {
                        print("Order ID:", orderId)
                        self.orderID = orderId
                    } else {
                        print("Unable to extract order ID from the response")
                    }
                } catch {
                    print("Error parsing JSON:", error.localizedDescription)
                }
            case .failure(let error):
                // Handle error
                print("Error:", error.localizedDescription)
            }
        }
    }
    
    func getPaymentToken(){
        let apiUrl = URL(string: "https://accept.paymob.com/api/acceptance/payment_keys")!
        
        let billingData: [String: Any] = [
            "apartment": "803",
            "email": "mahmoud@gmail.com",
            "floor": "5",
            "first_name": "Mahmoud",
            "street": "Faysel",
            "building": "8028",
            "phone_number": "01148143311",
            "shipping_method": "PKG",
            "postal_code": "01898",
            "city": "Jaskolskiburgh",
            "country": "EG",
            "last_name": "Atrees",
            "state": "Cairo"
        ]
        
        let body: [String: Any] = [
            "auth_token": "\(firstToken)",
            "amount_cents": "500000",
            "expiration": 3600,
            "order_id": "\(orderID)",
            "billing_data": billingData,
            "currency": "EGP",
            "integration_id": 4283915,
            "lock_order_when_paid": "false",
        ]
        
        networkLayer.sendPostRequest(apiURL: apiUrl, body: body) { result in
            switch result {
            case .success(let data):
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let paymentToken = json["token"] as? String {
                        print("Token:", paymentToken)
                        self.paymentToken = paymentToken
                        
                    } else {
                        print("Failed to extract token from the response")
                    }
                } catch {
                    print("Error parsing JSON:", error.localizedDescription)
                }
            case .failure(let error):
                // Handle error
                print("Error:", error.localizedDescription)
            }
        }
    }
    
}

