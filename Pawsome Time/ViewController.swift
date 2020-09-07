//
//  ViewController.swift
//  Pawsome Time
//
//  Created by Lee Justin on 11/14/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {

    // sign in button
    @IBOutlet weak var signInButton: UIButton!
    // username
    @IBOutlet weak var inputUsername: UITextField!
    // password
    @IBOutlet weak var inputPassword: UITextField!
    // create account button
    @IBOutlet weak var createAccountButton: UIButton!
    
    // email variable to pass account data
    var email = ""
    
    
    
    
    // Create Account Button - segues to Create Account vc
    @IBAction func moveToCreateAccount(_ sender: Any) {
        
        // move to CreateAccount vc
        print ("Move to CreateAccount vc")
        self.performSegue(withIdentifier: "CreateAccountSegue", sender: self)
        
    }
    
    var emailArray = [String]()
    
    // Sign in button - takes you to Main page if authenticated else displays error message
    @IBAction func moveToMainPage(_ sender: Any) {
        
        
        // store email found
        var emailAddress = ""
        
        // find email from inputted username and password
        let ref = Database.database().reference()
        ref.child("userid").observeSingleEvent(of: .value, with: { snapshot in
            
            // iterate through database
            for child in (snapshot.children) {
                
                // make each child a snapshot
                let snap = child as! DataSnapshot
                print (snap)
                // value is dict
                let dict = snap.value as? NSDictionary

                // get the values in variables
                let username = dict?["username"] as? String ?? ""
                let password = dict?["password"] as? String ?? ""
//                print (username!)
//                print (password!)
                
                // check if any username/password matches inputted username/password, then get email
                if (username == self.inputUsername.text! && password == self.inputPassword.text!) {
                    print ("found match!")
                    
                    // get the email
                    emailAddress = dict?["email"] as? String ?? ""
                    print ("current email: " + emailAddress)
                    
                    // sign in using email and password
                    if (emailAddress != "") {
                        print ("Signing in...")
                        Auth.auth().signIn(withEmail: emailAddress, password: self.inputPassword.text!)
                        
                        // set email field for the class - this is to allow the prepare for segue to get the info
                        self.email = emailAddress;
                    
                        // move to mainpage vc
                        print ("Moving to Main Page")
                        mainInstance.name = username
                        print(mainInstance.name)
                        // perform segue
                        self.performSegue(withIdentifier: "MoveToMain", sender: self)
                    }
                    
                    
  
                }
                else {
                    print ("wrong username/pass")
                }
                
                
//                print ("next item...")
                
                
            }
            // reset text fields
            self.inputUsername.text = ""
            self.inputPassword.text = ""
            
            // if we are here -> then there was an error
            // create an alert
            let alert = UIAlertController(title: "Error", message: "Incorrect email/pass", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            
        })
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        // check identifier
        if (segue.identifier == "MoveToMain") {
            
            // get destination view controller -> Mainsc
            let dest_vc = segue.destination as! Mainsc
            
            // create account object
            let myAccount = Account.init(accountid: inputUsername.text!, accountpw: inputPassword.text!, email: self.email)
            
            // pass the account object to the next vc
            dest_vc.account = myAccount
            
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // log out the user first
        do {
            try Auth.auth().signOut()
        }
        catch let err{
            print (err)
        }

        
        
        
        
    }


}

