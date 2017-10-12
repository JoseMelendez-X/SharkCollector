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
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create logout bar button item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
      
    }

    
    //MARK: - TableviewFunctions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

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
    
 

 }
