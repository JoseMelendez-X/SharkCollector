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
    let debt: Double

    //Image of the borrower
    let imageOfBorrower: UIImage?
    
    //Initializer
    init(name: String, debt: Double, imageOfBorrower: UIImage?) {
        
        self.name = name
        
        self.debt = debt
        
        self.imageOfBorrower = imageOfBorrower
        
    }
}
