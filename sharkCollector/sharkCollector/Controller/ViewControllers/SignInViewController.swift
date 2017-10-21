//
//  SignInViewController.swift
//  sharkCollector
//
//  Created by Jose Melendez on 10/10/17.
//  Copyright © 2017 JoseMelendez. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignInViewController: UIViewController {
    
    //MARK: - IB-Outlets
   
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide the navigation bar
        self.navigationController?.isNavigationBarHidden = true
        
        signInButton.layer.borderWidth = 1.0
        signInButton.layer.cornerRadius = 5
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.cornerRadius = 5
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    //MARK: - IB-Actions
    
    //SignIn Button
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        //loading animation start
        SVProgressHUD.show()
        
        //Unwrap optional values
        if let email = emailTextfield.text, let password = passwordTextfield.text {
        
        //Sign in user with email and password
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                
                //Handle errors here
                self.emailErrorLabel.text = "Email or password is incorrect. Please try again"
                print(error!.localizedDescription)
                
                //Dismiss loading animation
                SVProgressHUD.dismiss()
                
            } else {
                
                //Handle successfull logins here
                
                print("log in was successfull")
                
                //Send user to the BorrowersTVC
                self.performSegue(withIdentifier: "toBorrowersTVC", sender: self)
                
                //Clear password text
                self.passwordTextfield.text = ""
                
                
                //Erase error label text
                self.emailErrorLabel.text = ""
                
                //Dismiss loading animation
                SVProgressHUD.dismiss()
            }
        }
    }
        
    }
    
    //SignUp Button
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
   
        //Send user to signUpVC when this button is clicked
        performSegue(withIdentifier: "toSignUpVC", sender: self)
      
    }
    
    
    //MARK: - Functions
    
    //touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Dismiss keyboard
        self.view.endEditing(true)
    }
    
}
