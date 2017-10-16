//
//  BorrowerViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit
import Firebase
class BorrowerViewController: UIViewController{
    
    //MARK: - Variables and Constants
    var name: String?
    var debt: String?
    var dateDisplayed: String?
    

    //MARK: - IB-Outlets
    @IBOutlet weak var borrowerNameLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var paymentTextfield: UITextField!
    @IBOutlet weak var borrowerImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //Set borrowerName text equal to name
        borrowerNameLabel.text = name
        debtLabel.text = "Debt: $\(debt!)"
        
        //Change the configuration of the date picker
        datePicker.datePickerMode = .date
        
    }
    
    
    @IBAction func pickedDateOfPayment(_ sender: UIDatePicker) {
        
        //Grab the date currently displayed by the UIDatePicker
        dateDisplayed = "\(sender.date)"
    }
    
    //Payment button tapped
    @IBAction func addPaymentButtonTapped(_ sender: UIButton) {
        
        //If Payment amount is empty, return
        if paymentTextfield.text == "" {
            return
        }
        
        //Send payments to the payments database
        sendPaymentsToDatabase()

        //Send user to PaymentsTVC
        performSegue(withIdentifier: "toPaymentsTVC", sender: self)
        
    }
    
    
    @IBAction func paymentsFolderTapped(_ sender: UIBarButtonItem) {
        
        //Send user to the PaymentsTVC
        performSegue(withIdentifier: "toPaymentsTVC", sender: self)
        
       
    }
    
    //Touches began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    //MARK: Firebase functions
    
    func sendPaymentsToDatabase() {
        
        //Create a database called payments
        let paymentDB = Database.database().reference().child("Payments").child((Auth.auth().currentUser?.uid)!)
        
        
        //Unwrap Optionals
        if let debt = debt, let date = dateDisplayed {
            
        //Properties and values of our database
        let paymentDictionary = ["Amount paid" : debt, "Date": date] as [String : String]
        
        //Creates unique identifier for each entry to the database and sets the values
        paymentDB.childByAutoId().setValue(paymentDictionary) {
            (error, ref) in
            
            if error != nil {
                //Handle errors here
                print(error!.localizedDescription)
                
            } else {
                
                //Handle success here
                let payment = Payment(amountPaid: Double(debt)!, dateOfPayment: date)
                
                print("Saved successfully")
            }
        }
    }
}
}
