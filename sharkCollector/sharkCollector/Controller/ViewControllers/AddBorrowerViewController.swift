//
//  AddBorrowerViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit

//MARK: Protocols
protocol addBorrowerDelegate {
    
    //Add name to the BorrowersTableView
    func addNameToTableView(name: String)
}

class AddBorrowerViewController: UIViewController {

    //MARK: - Variables and Constants
    
    //Delegate variable
    var delegate: addBorrowerDelegate?
    
    //MARK: - IB-Outlets
    @IBOutlet weak var enterNameTextfield: UITextField!
    @IBOutlet weak var enterAmountOfDebtTextfield: UITextField!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - IB-Actions
    @IBAction func addBorrowerButtonTapped(_ sender: UIButton) {
        
        
    }
    

}
