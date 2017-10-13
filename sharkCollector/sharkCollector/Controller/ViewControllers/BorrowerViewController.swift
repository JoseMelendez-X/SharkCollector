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
    @IBOutlet weak var borrowerNameLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var paymentTextfield: UITextField!
    @IBOutlet weak var borrowerImageView: UIImageView!
 
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //Set borrowerName text equal to name
        borrowerNameLabel.text = name
        
    }
    
    
    @IBAction func pickedDateOfPayment(_ sender: UIDatePicker) {
        
        
    }
    
    @IBAction func addPaymentButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func paymentsFolderTapped(_ sender: UIBarButtonItem) {
    }
    
}
