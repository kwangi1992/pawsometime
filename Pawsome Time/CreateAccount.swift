//
//  CreateAccount.swift
//  Pawsome Time
//
//  Created by Lee Justin on 11/24/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

// handle new users here
class CreateAccount: UIViewController {
    
    // variables on page
    @IBOutlet weak var inputUsername: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var inputEmail: UITextField!
    
    // create account button function
    @IBAction func moveToSignIn(_ sender: UIButton) {
        // display inputted text
        print (inputEmail.text!)
        print (inputUsername.text!)
        print (inputPassword.text!)
        
        
        
        
        // store new account info in database
        // create user w/ firebase authentication
        Auth.auth().createUser(withEmail: inputEmail.text!, password: inputPassword.text!) { authResult, error in
            
            if let err = error {
                print ("error: ", err)
            }
            else {
                
                if let currentUser = Auth.auth().currentUser?.createProfileChangeRequest() {
                    
                    // set name for the user as username
                    currentUser.displayName = self.inputUsername.text!
                    
                    // commit changes
                    currentUser.commitChanges { (error) in
                        if let e = error {
                            print ("there was a commit error: ", e)
                        }
                        else {
                            print ("working")
                        }
                    }
                    
                }
                print ("Creating new user...")
                
                // add the user to the database
                // create reference to database
                let ref = Database.database().reference();
                
                // create entry using email, username, pass
            ref.child("userid").child(self.inputUsername.text!).setValue(["email":self.inputEmail.text!, "username":self.inputUsername.text!, "password":self.inputPassword.text!]);
                
                
                
                // user is found -> go to sign in
                // move back to sign in page (ViewController vc)
                self.performSegue(withIdentifier: "SignInSegue", sender: self)
            }
            
            
        }
        
        
        
        
    }
    
    @IBAction func BackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    


}
