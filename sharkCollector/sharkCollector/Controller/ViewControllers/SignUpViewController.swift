//
//  SignUpViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignUpViewController: UIViewController {

    //MARK: - IB-Outlets
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmationPasswordTextfield: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make create account button rounded
        createAccountButton.layer.cornerRadius = 5
        
    }
    
    //MARK: - IB-Actions
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        
        //Start loading animation
        SVProgressHUD.show()
        
        //Unwrap optionals
        if let email = emailTextfield.text, let password = passwordTextfield.text, let confirmPassword = confirmationPasswordTextfield.text  {
            
            if password == confirmPassword {
                
            //Create account/user
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                
                if error != nil {
                    
                    //Handle errors here
                    print(error!.localizedDescription)
                    
                    //Dismiss loading animation
                    SVProgressHUD.dismiss()
                    
                } else {
                    
                    //Handle successful creation of new user here
                    
                    print("Success, new account created")
                    
                    //Send user to BorrowersTVC
                    self.performSegue(withIdentifier: "toBorrowersTVC", sender: self)
                    
                    //Dismiss loading animation
                    SVProgressHUD.dismiss()
                    
                }
                
            })
                
            } else {
                
                //Handle password erros here
                print("Passwords do not match")
                
                //Dismiss loading animation
                SVProgressHUD.dismiss()
                
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
