//
//  BorrowerViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit

class BorrowerViewController: UIViewController {
    
    //MARK: - Variables and Constants
    var name: String?

    //MARK: - IB-Outlets
    @IBOutlet weak var borrowerName: UILabel!
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //Set borrowerName text equal to name
        borrowerName.text = name
        
    }
    
    



}
