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
            
            if error != nil {
                
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    if error != nil {
                        print("We have an \(String(describing: error))")
                    } else {
                        
                        // Creating database for users on Firebase
                        
                        FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                        
                        
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                        
                    }
                })
                
            } else {
                
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        })
        
    }
    
}
