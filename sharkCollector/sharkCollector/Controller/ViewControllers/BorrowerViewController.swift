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
    
    //Declare the delegate variable here:
   
    

    //MARK: - IB-Outlets
    @IBOutlet weak var borrowerNameLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var paymentTextfield: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //Set borrowerName text equal to name
        borrowerNameLabel.text = borrowerAtIndex.name
        debtLabel.text = "Debt: $\(borrowerAtIndex.debt)"
        
        //Change the configuration of the date picker
        datePicker.datePickerMode = .date
        
        print(borrowerAtIndex.name)
        
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
        

        //Send user to PaymentsTVC
        performSegue(withIdentifier: "toPaymentsTVC", sender: self)
        
    }
    
    //Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPaymentsTVC" {

            let destinationVC = segue.destination as! PaymentsTableViewController
            
            destinationVC.borrowerAtIndex = borrowerAtIndex
            
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
        if let paid = paymentTextfield.text, let date = dateDisplayed {
            
        //Properties and values of our database
        let paymentDictionary = ["Amount paid" : paid, "Date": date] as [String : String]
        
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
