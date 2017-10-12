//
//  BorrowersTableViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit
import Firebase

class BorrowersTableViewController: UITableViewController, addBorrowerDelegate {
    
    //MARK: Variables and Constants
    
    //Array of borrowers
    var borrowers = [Borrower]()

    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create logout bar button item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
      
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
        
        if segue.identifier == "toAddBorrowerVC" {
            
            let destinationVC = segue.destination as! AddBorrowerViewController
            
            //Set the delegate to self
            destinationVC.delegate = self
        }
        
    }
    
    //MARK: - Protocol Functions
    func addBorrowerToTableView(name: String, debt: String) {
        
        //Create a borrower
        let borrower = Borrower(name: name, debt: debt)
        
        //Add the created borrower to the array of borrowers
        borrowers.append(borrower)
        
        //Reload Data
        tableView.reloadData()
    }
    
    
    

    

 }
