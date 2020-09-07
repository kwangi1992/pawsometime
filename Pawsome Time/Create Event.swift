//
//  Create Event.swift
//  Pawsome Time
//
//  Created by kwangi yu on 11/23/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import Firebase
class Create_Event: UIViewController {
    var logi: Double?
    var lati: Double?
    
    
    @IBOutlet var createButton: UIButton!
    @IBOutlet var eventDescription: UITextView!
    @IBOutlet var eventLocation: UITextView!
    @IBOutlet var eventName: UITextView!
    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //button shape and lable shape, color
        createButton.layer.cornerRadius = 10
        let myColor = UIColor.black
        self.eventLocation.layer.borderWidth = 1.0
        self.eventDescription.layer.borderWidth = 1.0
        self.eventName.layer.borderWidth = 1.0
        self.eventDescription.layer.borderColor = myColor.cgColor
        self.eventLocation.layer.borderColor = myColor.cgColor
        self.eventName.layer.borderColor = myColor.cgColor
   

    }
    
    //creat event
    @IBAction func createEvent(_ sender: Any) {
        //convert logi and lati to one string
        let a:Double = logi!
        let b:String = String(format: "%f", a)
        let c = b.components(separatedBy: ".").joined()
        let d:Double = lati!
        let e:String = String(format: "%f", d)
        let f = e.components(separatedBy: ".").joined()
        let z = c + f
       
       
        // create the event
        let myEvent = EventsOb(eventName: self.eventName.text!, eventLocation: self.eventLocation.text!, eventDescription: eventDescription.text!)

        
        
        // add to the database
        let ref = Database.database().reference()
        ref.child("Events").child(z).child(self.eventName.text).setValue(["Event": self.eventName.text!, "eventLocation": self.eventLocation.text!, "eventDescription": eventDescription.text!, "Host": mainInstance.name])
        
        //host check in 
        ref.child("Events").child(z).child(self.eventName.text).child("checkIn").child(mainInstance.name).setValue(["UserId" : mainInstance.name, "DogName" : mainInstance.dog, "Birth" : mainInstance.birth, "Personality" : mainInstance.personal, "Breed" : mainInstance.breed, "Size" : mainInstance.size, "url" : mainInstance.url])
        ref.child("Events").child("checkInUser").child(self.eventName.text).child(mainInstance.name).setValue(["EventName" : self.eventName.text!, "EventLocation": self.eventLocation.text!, "EventDetail": self.eventDescription.text!, "Map": z])


        
        
        //back to privious page
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)

    }
    
    
    //back button
    @IBAction func BackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // moving to specific event page
        if (segue.identifier == "MoveToSpecEventPage") {
            // get destination vc
            let dest_vc = segue.destination as! Specific_Event_Page
            
            
        }
    }
    
    
    


}
