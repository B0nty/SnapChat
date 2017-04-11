//
//  ViewController.swift
//  SnapChat-clone
//
//  Created by Jernej Hartman on 09/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func turnUpTapped(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("Wee try to sign in")
            if error != nil {
                print(" we have an error")
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    if error != nil {
                        print("We have an error")
                    } else {
                        print("Created user successfuly")
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                        
                            }
                })
            } else {
                print("Sign in OK")
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        })
        
    }
    
   }
