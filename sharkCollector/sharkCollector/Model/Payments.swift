//
//  Payments.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import Foundation

class Payments {
    
    //Amount paid
    let amountPaid: Double
    
    //Date of payment
    let dateOfPayment: String
    
    //Initializer
    init(amountPaid: Double, dateOfPayment: String) {
        
        self.amountPaid = amountPaid
        
        self.dateOfPayment = dateOfPayment
    }
}
