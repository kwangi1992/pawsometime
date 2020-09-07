//
//  Mainsc.swift
//  Pawsome Time
//
//  Created by kwangi yu on 11/23/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Mainsc: UIViewController {

    
    // buttons
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
   
    
    // set up to hold the account
    var account: Account?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapButton.layer.cornerRadius = 10
        profileButton.layer.cornerRadius = 10
        let ref = Database.database().reference()
        ref.child("userid").child(mainInstance.name).child("profile").observe(DataEventType.value, with: { snapshot in
                   
                   for child in (snapshot.children){
                       
                    
                       let snap = child as! DataSnapshot
                    
                    
                    
                    
                    
                       
        let dict = snap.value as! [String:String]
                        //dog information profile
                        print(dict)
                        print(dict["Breed"])
                       
                        let Dogname = dict["DogName"]
                       
                        let breed = dict["Breed"]
                       
                        let size = dict["Size"]
                           
                        let dof = dict["dof"]
                        
                        let personality = dict["Personality"]
                       
                        let imageUrlString = dict["PhotoUrl"]
                    
                        let imageUrl = URL(string: imageUrlString!)

                        let imageData = try! Data(contentsOf: imageUrl!)

                    mainInstance.url = imageUrlString!
                    mainInstance.birth = dof!
                    mainInstance.dog = Dogname!
                    mainInstance.personal =  personality!
                    mainInstance.size = size!
                    mainInstance.breed = breed!
                    
                       
                    print(breed)
                       
                       
                   }
        })

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        if Auth.auth().currentUser != nil {
            print ("user is logged in!")
        }
        else {
            print ("nobody is logged in")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
 
    }

    @IBAction func ProfileButton(_ sender: Any) {
        self.performSegue(withIdentifier: "MoveToProfile", sender: self)
    }
    @IBAction func Map(_ sender: Any) {
        self.performSegue(withIdentifier: "MoveToMap", sender: self)
    }
    
    @IBAction func EventButton(_ sender: Any) {
        self.performSegue(withIdentifier: "MoveToEvents", sender: self)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // PROFILE
        
        
        // VIEW MAP
        
        
        
        // EVENTS LIST LOCATION
 
        
        
    }

}
