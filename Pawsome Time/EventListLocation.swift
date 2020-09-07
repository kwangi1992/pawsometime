//
//  EventListLocation.swift
//  Pawsome Time
//
//  Created by kwangi yu on 11/28/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import Firebase
class EventListLocation: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var createButton: UIButton!
    // account data
    @IBOutlet var removePin: UIButton!
    
    
    // Map data
    var logi:Double?
    var lati:Double?
    
    // table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.EventTest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for:indexPath) as! TableViewCell
        let Event: EventsOb
        Event = EventTest[indexPath.row]
        cell.EventName.text = Event.eventName
        cell.EventLocation.text = Event.eventLocation
        cell.EventDetail.text = Event.eventDescription
        
        return cell
    }
    var valueToPass: String!
    var valueToPass2: String!
    var valueToPassDetail: String!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")

        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath) as! TableViewCell

        valueToPass = currentCell.EventName.text
        valueToPass2 = currentCell.EventLocation.text
        valueToPassDetail = currentCell.EventDetail.text
        performSegue(withIdentifier: "MoveToSpecEventPage", sender: self)
    }


    
    var EventTest: [EventsOb] = []


    @IBOutlet var eventss: UILabel!

    @IBOutlet var myTableView: UITableView!

    

    override func viewDidLoad() {
        
        myTableView.dataSource = self
        myTableView.delegate = self
        super.viewDidLoad()
        //button shape
        createButton.layer.cornerRadius = 10
        removePin.layer.cornerRadius = 10
        //convert logi + lati data to one string
        let a:Double = logi!
        let b:String = String(format: "%f", a)
        let c = b.components(separatedBy: ".").joined()
        let d:Double = lati!
        let e:String = String(format: "%f", d)
        let f = e.components(separatedBy: ".").joined()
        let z = c + f
       

        
        //EventTest.append(myEvent)
        let ref = Database.database().reference()
 
        ref.child("Events").child(z).observe(DataEventType.value) { (snapshot) in
            self.EventTest.removeAll()
            
            
            
            for child in (snapshot.children){
                
                // make each child a snapshot
                let snap = child as! DataSnapshot
                
                // value is dict
                let dict = snap.value as! NSDictionary
                
                // get the values in variables
                let Event = dict["Event"] as? String ?? ""

                let eventLocation = dict["eventLocation"] as? String ?? ""
                let eventDescription = dict["eventDescription"] as? String ?? ""
                let EventS : String = Event
                let eventLoS : String = eventLocation
                let eventD: String = eventDescription
                if (!EventS.isEmpty && !eventLoS.isEmpty && !eventLoS.isEmpty){
                    let myEvent = EventsOb(eventName: EventS, eventLocation: eventLoS, eventDescription: eventD)
                    self.EventTest.append(myEvent)
                }
                
            }
            self.myTableView.reloadData()
        }
        


    }
    @IBAction func removePin(_ sender: Any) {
        let ref = Database.database().reference()
        ref.child("locations").observe(DataEventType.value) { (snapshot) in
            for child in (snapshot.children){
                let snap = child as! DataSnapshot
                let dict = snap.value as! NSDictionary
                let Logi = dict["longitude"] as! Double
                let Lati = dict["lagitude"] as! Double
                let a:Double = self.logi!
                let b:String = String(format: "%f", a)
                let c = b.components(separatedBy: ".").joined()
                let d:Double = self.lati!
                let e:String = String(format: "%f", d)
                let f = e.components(separatedBy: ".").joined()
                let z = c + f
                print("check")
                print(Logi)
                print(d)
               // print(Logi)
              //  print(Lati)
                if(d.isEqual(to: Logi) && a.isEqual(to: Lati)){
                    
                    
                    
                    ref.child("Events").child(z).observe(DataEventType.value)  {(snapshot) in
                        if snapshot.childrenCount > 0{
                            self.removePin.isEnabled = false
                            print("Yes")
                            
                            
                        }
                        else{
                            
                            print("No")
                            ref.child("Events").child(z).removeValue()
                            ref.child("locations").child(snap.key).removeValue()
                            
                            self.navigationController?.popViewController(animated: true)

                            self.dismiss(animated: true, completion: nil)

                            
                        }
                    }
                    
                    

                }
            }
        }
        
            
    }
    
    @IBAction func EventDetail(_ sender: Any) {
        self.performSegue(withIdentifier: "MoveToSpecific", sender: self)
    }
    
    @IBAction func CreateEvent(_ sender: Any) {
        self.performSegue(withIdentifier: "MoveToCreateEvent", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "MoveToCreateEvent"){
            // destination view controller
            let dest_vc = segue.destination as! Create_Event

            // add variables to next vc
            dest_vc.logi = self.logi;
            dest_vc.lati = self.lati;
            
            
            
            
        }
        if(segue.identifier == "MoveToSpecEventPage"){
            let dest_vc = segue.destination as! Specific_Event_Page
            dest_vc.Location = self.valueToPass2
            dest_vc.Detail = self.valueToPassDetail
            dest_vc.EventName = self.valueToPass
            dest_vc.logi = self.logi
            dest_vc.lati = self.lati
        }
        
    }
    
    @IBAction func backbutton(_ sender: Any) {

        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)

        
    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


