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
    
    //Singleton
    static let sharedInstance = BorrowerViewController()
    
    //MARK: - Variables and Constants
    var name: String?
    var paid: String?
    var dateDisplayed: String?
    var borrowerAtIndex: Borrower!
    var selectedDate = ""
    let dateFormatter = DateFormatter()
    var currentDebt = 0.0
    var refKey: String?
    
    
    //MARK: - IB-Outlets
    @IBOutlet weak var borrowerNameLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var paymentTextfield: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addPaymentButton: UIButton!
    
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //Set borrowerName text equal to name
        borrowerNameLabel.text = borrowerAtIndex.name
        debtLabel.text = "Debt: $\(borrowerAtIndex.debt)"
        
        //Change the configuration of the date picker
        datePicker.datePickerMode = .date
        dateFormatter.dateFormat = "MMM dd, yyy"
      
        print(refKey!)
        
        //Make add payment button rounded
        addPaymentButton.layer.cornerRadius = 5
        
        paymentTextfield.placeholder = "Payment Amount"
    }
 
    
    @IBAction func paymentsFolderButtonTapped(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "toPaymentsTVC", sender: self)
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
        self.sendPaymentsToDatabase()
        
        //Set current debt value
        currentDebt = Double(borrowerAtIndex.debt)! - Double(paymentTextfield.text!)!
        
        //Set the borrwers debt to the current debt
        borrowerAtIndex.debt = String(currentDebt)
        
        //Create a reference to the database
       let debtNode = Database.database().reference().child("Borrowers").child((Auth.auth().currentUser?.uid)!)
        
        //Locate the specific node you would like to update
        debtNode.child(refKey!).updateChildValues(["debt" : String(currentDebt)])
        
     //Send user to PaymentsTVC
     performSegue(withIdentifier: "toPaymentsTVC", sender: self)

    }
    
    //Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPaymentsTVC" {

            let destinationVC = segue.destination as! PaymentsTableViewController
            
            destinationVC.borrowerAtIndex = borrowerAtIndex
            
            destinationVC.customDate = selectedDate
       }
        
    }
    
    //Touches began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    //MARK: Firebase functions
    
    func sendPaymentsToDatabase() {
        
        //Create a database called payments
        let paymentDB = Database.database().reference().child("Payments").child((Auth.auth().currentUser?.uid)!).child(borrowerAtIndex.name)
        
        //Unwrap Optionals
        if let paid = paymentTextfield.text {
            
        //Configure the selected date
        selectedDate = dateFormatter.string(from: datePicker.date)
            
        //Properties and values of our database
        let paymentDictionary = ["Amount paid" : paid, "Date": selectedDate] as [String : String]
        
        //Creates unique identifier for each entry to the database and sets the values
        paymentDB.childByAutoId().setValue(paymentDictionary) {
            
            (error, ref) in
            
            if error != nil {
                
                //Handle errors here
                print(error!.localizedDescription)
                
            } else {
                
                //Handle success here
                print("Saved successfully")
          }
        }
      }
    }
}
