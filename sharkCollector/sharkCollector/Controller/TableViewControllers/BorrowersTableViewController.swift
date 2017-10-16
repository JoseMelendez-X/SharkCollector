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

    static let sharedInstance = BorrowersTableViewController()
    //MARK: Variables and Constants
    
    var borrower: Borrower?
    
    //Array of borrowers
    var borrowers = [Borrower]()
    
    var indexOfRowUserClicked: Int = 0
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create logout bar button item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
      
        //When the view loads retrieve borrowers
      
        retrieveBorrowersFromDatabase()
        
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
    
    
    
    //MARK: - Firebase functions
    
    func retrieveBorrowersFromDatabase() {
        
        //Reference the database created in AddBorrowerVC
        let borrowersDB = Database.database().reference().child("Borrowers").child((Auth.auth().currentUser?.uid)!)
        
        //When new Borrower is added, we will grab that new borrower that was added
        borrowersDB.observe(.childAdded) { (snapshot) in
        
            //Grab the snapshot value wich in our case is [String: String]
            //The value of the snapshot needs to be casted as [String: String]
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            let name = snapshotValue["name"]!
            let debt = snapshotValue["debt"]!
            
            //Create a Borrower object
            self.borrower = Borrower(name: name, debt: debt)
            
            //Set the tracker of borrower
            self.borrower?.tracker = self.indexOfRowUserClicked
            
            //Append this newly created object to the borrowers array
            self.borrowers.append(self.borrower!)
            
            //Reload data
            self.tableView.reloadData()
            
        }
    }
    
 }
