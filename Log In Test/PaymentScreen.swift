//
//  PaymentScreen.swift
//  Log In Test
//
//  Created by Abhi Madduri on 7/28/20.
//

import UIKit


class PaymentScreen: UIViewController {
    
    var paymentType = ""
    
    @IBOutlet weak var typeOfPayment: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeOfPayment.text = paymentType
    }
    
    
    
}
