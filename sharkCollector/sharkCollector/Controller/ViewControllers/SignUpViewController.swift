//
//  SignUpViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    //MARK: - IB-Outlets
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmationPasswordTextfield: UITextField!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - IB-Actions
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        
        //Unwrap optionals
        if let email = emailTextfield.text, let password = passwordTextfield.text, let confirmPassword = confirmationPasswordTextfield.text  {
            
            if password == confirmPassword {
                
            //Create account/user
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                
                if error != nil {
                    
                    //Handle errors here
                    print(error!.localizedDescription)
                    
                } else {
                    
                    //Handle successful creation of new user here
                    
                    print("Success, new account created")
                    
                    //Send user to BorrowersTVC
                    self.performSegue(withIdentifier: "toBorrowersTVC", sender: self)
                    
                }
                
            })
                
            } else {
                
                //Handle password erros here
                print("Passwords do not match")
                
            }
        }
        
    }
    
    
    //MARK: - Functions
    
    //touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Dismiss keyboard
        self.view.endEditing(true)
    }
    
    
}
