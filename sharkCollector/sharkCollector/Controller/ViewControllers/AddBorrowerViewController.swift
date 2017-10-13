//
//  AddBorrowerViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit
import Firebase

class AddBorrowerViewController: UIViewController {

    //MARK: - Variables and Constants

    //MARK: - IB-Outlets
    @IBOutlet weak var enterNameTextfield: UITextField!
    @IBOutlet weak var enterAmountOfDebtTextfield: UITextField!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - IB-Actions
    @IBAction func addBorrowerButtonTapped(_ sender: UIButton) {
      
            //Send information that the user entered to the database
             sendBorrowersToDatabase()
            
            //Go back to BorrowersVC
            navigationController?.popViewController(animated: true)

    }
    
    //MARK: - Firebase functions
    
    func sendBorrowersToDatabase() {
        
        //Creates a database named Borrowers
        let borrowers = Database.database().reference().child("Borrowers").child((Auth.auth().currentUser?.uid)!)
        
        //Properties and values of our database
        let borrowersDictionary = ["name": enterNameTextfield.text!, "debt": enterAmountOfDebtTextfield.text!, "email": Auth.auth().currentUser?.email]
        
        //Creates unique identifier for each entry to the database and sets the values
        borrowers.childByAutoId().setValue(borrowersDictionary) {
            (error, ref) in
                
                if error != nil {
                    
                    //Handle errors here
                    print(error!)
                    
                } else {
                    
                    //Handle success here
                    print("messsaged saved successfully")
                    
            }
        }
    }

}
