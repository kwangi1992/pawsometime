//
//  Specific Event Page.swift
//  Pawsome Time
//
//  Created by kwangi yu on 11/23/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import Firebase
class Specific_Event_Page: UIViewController {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    var EventName: String?
    var Location: String?
    var Detail: String?
    var logi: Double?
    var lati: Double?
    
    @IBOutlet var checkInButton: UIButton!
    @IBOutlet var checkInUserButton: UIButton!

    
    
    override func viewDidLoad() {
        // button shape and border shape and collor
        super.viewDidLoad()
        checkInButton.layer.cornerRadius = 10
        checkInUserButton.layer.cornerRadius = 10
        
        let myColor = UIColor.black
        self.eventLocation.layer.borderWidth = 1.0
        self.eventDescription.layer.borderWidth = 1.0
        self.eventName.layer.borderWidth = 1.0
        self.eventDescription.layer.borderColor = myColor.cgColor
        self.eventLocation.layer.borderColor = myColor.cgColor
        self.eventName.layer.borderColor = myColor.cgColor

       
        self.eventName.text = EventName
        self.eventLocation.text = Location
        self.eventDescription.text = Detail
        
        
    }
    //back button
    @IBAction func BackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    // back to map
    @IBAction func BackToMap(_ sender: Any) {
        self.performSegue(withIdentifier: "BackToMap", sender: self)
    }

    // check in
    @IBAction func checkInButton(_ sender: Any) {
        //covert logi and lati
        let a:Double = logi!
        let b:String = String(format: "%f", a)
        let c = b.components(separatedBy: ".").joined()
        let d:Double = lati!
        let e:String = String(format: "%f", d)
        let f = e.components(separatedBy: ".").joined()
        let z = c + f
        print(z + "Check dsfdddddasdfasdfasdsdf")
        //data base part. Save check in user in the events
        let ref = Database.database().reference()
        ref.child("Events").child(z).child(self.EventName!).child("checkIn").child(mainInstance.name).setValue(["UserId" : mainInstance.name, "DogName" : mainInstance.dog, "Birth" : mainInstance.birth, "Personality" : mainInstance.personal, "Breed" : mainInstance.breed, "Size" : mainInstance.size, "url" : mainInstance.url])
        ref.child("Events").child("checkInUser").child(EventName!).child(mainInstance.name).setValue(["EventName" : EventName, "EventLocation": Location, "EventDetail": Detail, "Map": z])
        
// move to check in
        self.performSegue(withIdentifier: "MoveToCheckIns", sender: self)
    }
    
    //check in button
    @IBAction func CheckInUsers(_ sender: Any) {
        self.performSegue(withIdentifier: "MoveToUserP", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //convert logi and lati -> make child name logi+lati string
        let a:Double = logi!
        let b:String = String(format: "%f", a)
        let c = b.components(separatedBy: ".").joined()
        let d:Double = lati!
        let e:String = String(format: "%f", d)
        let f = e.components(separatedBy: ".").joined()
        let z = c + f
        //move to check in page
        if (segue.identifier == "MoveToCheckIns") {
            // get destination vc
            let dest_vc = segue.destination as! MyCheckIns
            
    
         
        }
        //Move to user Page and send data name and location lati and logi
        if (segue.identifier == "MoveToUserP"){
            let dest_vc = segue.destination as! CheckInUsers
            dest_vc.name = EventName
            dest_vc.map = z
            print(z)
            
        }
    }
    


}
