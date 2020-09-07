//
//  Profile.swift
//  Pawsome Time
//
//  Created by kwangi yu on 11/23/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import FirebaseDatabase
class Profile: UIViewController {

    @IBOutlet var Name: UITextField!
    
    @IBOutlet var DateOfBirth: UITextField!
    @IBOutlet var Personality: UITextField!
    @IBOutlet var Size: UITextField!
    @IBOutlet var Breed: UITextField!
    @IBOutlet weak var updateProfile: UIButton!

    @IBOutlet var profilePhoto: UIImageView!
    @IBOutlet var checkInButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        //button shape
        updateProfile.layer.cornerRadius = 10
        checkInButton.layer.cornerRadius = 10
        // get data from firebase
        let ref = Database.database().reference()
        //from profile
            ref.child("userid").child(mainInstance.name).child("profile").observe(DataEventType.value, with: { snapshot in
                   
                   for child in (snapshot.children){
                       
                    
                       let snap = child as! DataSnapshot
                    
                    
                    
                    
                    
                       
        let dict = snap.value as! [String:String]
                    // get data from firebase
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
                    
                    
                        self.DateOfBirth.text = dof
                        self.Personality.text = personality
                        self.Size.text = size
                        self.Name.text = Dogname
                        self.Breed.text = breed
                        self.profilePhoto.image = UIImage(data: imageData)
                    print(breed)
                       
                       
                   }
                   
                   
                   
               })

        // Do any additional setup after loading the view.
    }
    
//check in
    @IBAction func Checkin(_ sender: Any) {
        mainInstance.birth = self.DateOfBirth.text!
         mainInstance.dog = self.Name.text!
         mainInstance.personal = self.Personality.text!
         mainInstance.size = self.Size.text!
         mainInstance.breed = self.Breed.text!
        self.performSegue(withIdentifier: "MoveToCheckIn", sender: self)
    }
    
//back button
    @IBAction func BackButton(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
//update or add
    @IBAction func UpdateOrAdd(_ sender: Any) {
        self.performSegue(withIdentifier: "MoveToAdd", sender: self)
    }
// view check in
    @IBAction func ViewCheckIns(_ sender: Any) {
        
        self.performSegue(withIdentifier: "MoveToMyCheckIns", sender: self)
    }



}
