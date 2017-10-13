//
//  BorrowersTableViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit
import Firebase

class BorrowersTableViewController: UITableViewController {

    
    //MARK: Variables and Constants
    
    //Array of borrowers
    var borrowers = [Borrower]()
    
    var indexOfRowUserClicked: Int = 0

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create logout bar button item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
      
        //When the view loads retrieve borrowers
      
        retrieveInfoFromDatabase()
        
    }
    
    //MARK: - IB-Actions
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        //Segue to the AddBorrowerVC
        performSegue(withIdentifier: "toAddBorrowerVC", sender: self)
        
    }
    
    
    //MARK: - TableviewFunctions
    
    //numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return borrowers.count
    }

    //cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "borrowers", for: indexPath) 
        
        //Add the name to the table view
        cell.textLabel?.text = borrowers[indexPath.row].name
 
        return cell
    }

    //didSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Keep track of the row the user clicked
        indexOfRowUserClicked = indexPath.row
        
        //Send user to BorrowerVC, when cell is tapped
        performSegue(withIdentifier: "toBorrowerVC", sender: self)
        
    }

    
    //MARK: - Functions
    @objc func logoutButtonTapped() {
        
        do {
            //do this (signOut)
            try Auth.auth().signOut()
            
        } catch {
            //handle error
            print(error.localizedDescription)
        }
        
        //Pop back to the signInVC
        navigationController?.popToRootViewController(animated: true)
    }
    
    //Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toBorrowerVC" {
            
            let destinationVC = segue.destination as! BorrowerViewController
            
            //Give name a value
            destinationVC.name = borrowers[indexOfRowUserClicked].name
            //Give debt a value
            destinationVC.debt = borrowers[indexOfRowUserClicked].debt
            
        }
        
    }
    
    //MARK: - Protocol Functions
    
    //NOT NEEDED, FIREBASE RETRIEVE FUNCTION PERFORMES THE SAME TASK
    
//    func addBorrowerToTableView(name: String, debt: String, email: String) {
//
//        //Create a borrower
//        let borrower = Borrower(name: name, debt: debt, email: email)
//
//        //Add the created borrower to the array of borrowers
//        borrowers.append(borrower)
//
//        //Reload Data
//        tableView.reloadData()
//    }
    
    //MARK: - Firebase functions
    
    func retrieveInfoFromDatabase() {
        
        //Reference the database created in AddBorrowerVC
        let borrowersDB = Database.database().reference().child("Borrowers").child((Auth.auth().currentUser?.uid)!)
        
        //When new Borrower is added, we will grab that new borrower that was added
        borrowersDB.observe(.childAdded) { (snapshot) in
        
            //Grab the snapshot value wich in our case is [String: String]
            //The value of the snapshot is of type Any so it needs to be casted as [String: String]
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            let name = snapshotValue["name"]!
            let debt = snapshotValue["debt"]!
            
            //Create a Borrower object
            let borrower = Borrower(name: name, debt: debt)
            
            //Append this newly created object to the borrowers array
            self.borrowers.append(borrower)
            
            //Reload data
            self.tableView.reloadData()
        }
    }
    
 }
