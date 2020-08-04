//
//  SecondScreen.swift
//  Log In Test
//
//  Created by Abhi Madduri on 7/25/20.
//

import UIKit
import StoreKit


class SecondScreen: UIViewController, SKPaymentTransactionObserver {
    var secondScreenPayment = ""
    
    var productID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
    }
    
    
    @IBAction func consumablePressed(_ sender: UIButton) {
        secondScreenPayment = "Consumable"
        productID = "com.abhimadduri.Log_In_Test_Consumable"
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
            self.performSegue(withIdentifier: "PaymentScreen", sender: self)
        } else {
            print("No Payments")
        }
    }
    
    @IBAction func nonConsumablePressed(_ sender: UIButton) {
        secondScreenPayment = "Non-Consumable"
        productID = "com.abhimadduri.Log_In_Test_nonConsumable"
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
            self.performSegue(withIdentifier: "PaymentScreen", sender: self)
        } else {
            print("No Payments")
        }
    }

    
    
    @IBAction func subscriptionPressed(_ sender: UIButton) {
        secondScreenPayment = "Subscription"
        productID = "com.abhimadduri.Log_In_Test_Subscription"
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
            self.performSegue(withIdentifier: "PaymentScreen", sender: self)
        } else {
            print("No Payments")
        }
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                print("Transaction Successful")
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .failed {
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print(errorDescription)
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PaymentScreen
        destinationVC.paymentType = self.secondScreenPayment
        
    }
    
    
}
