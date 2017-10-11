//
//  SignInViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    //MARK: - IB-Outlets
   
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - IB-Actions
    
    //SignIn Button
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        //Unwrap optional values
        if let email = emailTextfield.text, let password = passwordTextfield.text {
        
        //Sign in user with email and password
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                
                //Handle errors here
                print(error!.localizedDescription)
                
            } else {
                
                //Handle successfull logins here
                
                print("log in was successfull")
                
                //Send user to the BorrowersTVC
                self.performSegue(withIdentifier: "toBorrowersTVC", sender: self)
                
            }
        }
    }
        
    }
    
    //SignUp Button
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        //Send user to signUpVC when this button is clicked
        performSegue(withIdentifier: "toSignUpVC", sender: self)
        
    }
    
}
