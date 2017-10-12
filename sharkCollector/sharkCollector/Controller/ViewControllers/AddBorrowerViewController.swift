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
    func addBorrowerToTableView(name: String, debt: String)
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
        
        //Unwrap optional
        if let name = enterNameTextfield.text, let debt = enterAmountOfDebtTextfield.text {
        
        //If delegate is not nil then execute the function
            delegate?.addBorrowerToTableView(name: name, debt: debt)
            
            //Go back to BorrowersVC
            navigationController?.popViewController(animated: true)
        }
    }
    

}
