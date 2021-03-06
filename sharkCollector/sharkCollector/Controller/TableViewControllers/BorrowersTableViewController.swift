//
//  BorrowersTableViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit
import Firebase

class BorrowersTableViewController: UITableViewController, UISearchBarDelegate{
    

    //MARK: Variables and Constants
    
    //Array of borrowers
    var borrowers = [Borrower]()
    var filteredBorrowers = [Borrower]()
    var shouldShowSearchResults = false
    var indexOfRowUserClicked: Int?
    
    //IB-Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create logout bar button item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        
        //Search bar delegate
        searchBar.delegate = self
    
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
        
        if shouldShowSearchResults {
            
           return filteredBorrowers.count
        }
        
        return borrowers.count
    }

    //cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "borrowers", for: indexPath)
        
        if shouldShowSearchResults {
            
            cell.textLabel?.text = filteredBorrowers[indexPath.row].name
            
            return cell
        } else {
        
        //Add the name to the table view
        cell.textLabel?.text = borrowers[indexPath.row].name
        
        return cell
        }
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
            
            //Pass the borrower to the BorrowerVC
            destinationVC.borrowerAtIndex = borrowers[indexOfRowUserClicked!]

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
            let borrower = Borrower(name: name, debt: debt)
            
            //Append this newly created object to the borrowers array
            self.borrowers.append(borrower)
            print(self.borrowers.count)
            //Reload data
            self.tableView.reloadData()
        }
    }
    
    //MARK: Search bar function
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        shouldShowSearchResults = true
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredBorrowers = borrowers.filter({ (borrower: Borrower) -> Bool in
            
            return borrower.name.lowercased().range(of: searchText.lowercased()) != nil
            
        })
    
        if searchText != "" {
            shouldShowSearchResults = true
            self.tableView.reloadData()
        } else {
            self.view.endEditing(true)
            shouldShowSearchResults = false
            self.tableView.reloadData()
        }
    }
    
 
    
 }
