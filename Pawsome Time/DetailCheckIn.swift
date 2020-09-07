//
//  DetailCheckIn.swift
//  Pawsome Time
//
//  Created by kwangi yu on 12/9/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import Firebase
class DetailCheckIn: UIViewController {
    var map: String!
    @IBOutlet var EventDetail: UITextView!
    @IBOutlet var EventLocation: UILabel!
    @IBOutlet var EventNAme: UILabel!
    var name: String?
    var location: String?
    var detail: String?
    
    @IBOutlet var checkOutButton: UIButton!
    @IBOutlet var CheckInUsers: UIButton!
    @IBOutlet var EventEndButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //button shape
        checkOutButton.layer.cornerRadius = 10
        CheckInUsers.layer.cornerRadius = 10
        EventEndButton.layer.cornerRadius = 10

        let myColor = UIColor.black
        self.EventLocation.layer.borderWidth = 1.0
        self.EventDetail.layer.borderWidth = 1.0
        self.EventNAme.layer.borderWidth = 1.0
        self.EventDetail.layer.borderColor = myColor.cgColor
        self.EventNAme.layer.borderColor = myColor.cgColor
        self.EventDetail.layer.borderColor = myColor.cgColor
        
        self.EventNAme.text = name
        self.EventLocation.text = location
        self.EventDetail.text = detail

        // Do any additional setup after loading the view.
    }
    //back button back to privious page
    
    @IBAction func BackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    //chck in user button
    @IBAction func CheckInUserButton(_ sender: Any) {
        performSegue(withIdentifier: "MoveToUsers", sender: self)
    }
    // send map and name data to check in users class
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check in
        if (segue.identifier == "MoveToUsers") {
            // get destination vc
            let dest_vc = segue.destination as! CheckInUsers;
            dest_vc.map = map
            dest_vc.name = name
            
        }
    }
    //Event end button for ending event
    @IBAction func EventEndButton(_ sender: Any) {

        let ref = Database.database().reference()
        
        
        //get data from fire base about host so make sure only host can end this event
        ref.child("Events").child(map).child(name!).child("Host").observe(DataEventType.value) { (snapshot) in
            
            
            let snap = snapshot.value as? String ?? ""
            
            if(snap == mainInstance.name){
                //if it is host then remove the event
                ref.child("Events").child("checkInUser").child(self.name!).removeValue()
                ref.child("Events").child(self.map).child(self.name!).removeValue()
                self.navigationController?.popViewController(animated: true)
                

                self.dismiss(animated: true, completion: nil)
      

                
            }
                
            
        }
        EventEndButton.isEnabled = false
           
           
  
        
        
    }
    // check out button
    @IBAction func CheckOutButton(_ sender: Any) {
        let ref = Database.database().reference()
        //remov event from check in list from event
        ref.child("Events").child(map).child(name!).child("checkIn").child(mainInstance.name).removeValue()
        //remove user from heck in user list
        ref.child("Events").child("checkInUser").child(name!).child(mainInstance.name).removeValue()
        navigationController?.popViewController(animated: true)
        

        dismiss(animated: true, completion: nil)
    }
    

}
