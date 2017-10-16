//
//  Borrower.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import Foundation
import UIKit

class Borrower {
    
    //Name
    let name: String
    
    //Debt
    let debt: String
    
    //Payments
    var payments = [Payment]()
    
    //Payment count
    var numberOfPayments = 0
    
    //Initializer
    init(name: String, debt: String) {
        
        self.name = name
        
        self.debt = debt
    
    }
}
