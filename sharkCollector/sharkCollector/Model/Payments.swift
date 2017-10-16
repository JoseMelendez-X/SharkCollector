//
//  Payments.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import Foundation

class Payment {
    
    //Amount paid
    var amountPaid: String
    
    //Date of payment
    let dateOfPayment: String
    
    //Initializer
    init(amountPaid: String, dateOfPayment: String) {
        
        self.amountPaid = amountPaid
        
        self.dateOfPayment = dateOfPayment
        
    }
    
}
