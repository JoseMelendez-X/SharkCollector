//
//  PaymentsTableViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit
import Firebase

class PaymentsTableViewController: UITableViewController {
    
    //MARK: Variables and Constants
    var borrowerAtIndex: Borrower?
    
    var payments = [Payment]()
    
    var customDate = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Retrieve payments from database
        retrievePayments()
    }


    // MARK: - Table view data source
 
    //numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return payments.count
       
    }
    
    //cellForAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "payments", for: indexPath) as! PaymentsTableViewCell
        
        //amount paid
        cell.amountPaidLabel.text = payments[indexPath.row].amountPaid
    
        //date of payment
        cell.dateOfPaymentLabel.text = payments[indexPath.row].dateOfPayment
        return cell
        
        
    }
    
    //MARK: - Firebase function
    
    func retrievePayments() {
            
        //Reference the database created in BorrowerVC
        let paymentDB = Database.database().reference().child("Payments").child((Auth.auth().currentUser?.uid)!).child((borrowerAtIndex?.name)!)
        
        //When a new payment is added, we will grab it.
        paymentDB.observe(.childAdded) { (snapshot) in
            
        //Grab the snapshot value wich in our case is [String: String]
        //The value of the snapshot needs to be casted as [String: String]
        let snapshotValue = snapshot.value as! Dictionary<String, String>
          
            let paymentValue = snapshotValue["Amount paid"]!
            let date = snapshotValue["Date"]!
            
            //Create a payment object
            let payment = Payment(amountPaid: paymentValue, dateOfPayment: date)
            
            //Append it to the payments array
            self.payments.append(payment)
            
            //Reload data
            self.tableView.reloadData()
            
            }
        }

}
