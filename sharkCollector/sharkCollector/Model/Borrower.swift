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
    var name: String
    
    //Debt
    var debt: String
    
    //Payments
    var payments = [Payment]()
    
    //Tracker
    var borrowerID = ""
    
    //Initializer
    init(name: String, debt: String) {
        
        self.name = name
        
        self.debt = debt
    
    }
}
