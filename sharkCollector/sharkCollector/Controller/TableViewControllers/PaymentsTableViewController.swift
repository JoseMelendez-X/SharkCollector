//
//  PaymentsTableViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit

class PaymentsTableViewController: UITableViewController {
    
    //MARK: Variables and Constants
    var payments = [Payment]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
 
    //numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return payments.count
    }
    
    //cellForAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "payments", for: indexPath)
        
        return cell
        
    }


}
