//
//  Mycheckin.swift
//  Pawsome Time
//
//  Created by kwangi yu on 11/23/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import Firebase
class MyCheckIns: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var valueToPass: String!
    var valueToPass2: String!
    var valueToPassDetail: String!
    var valueToPassMap: String!
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var MapButton: UIButton!
    var EventList: [EventsOb] = []
    var Map : [String] = []
    var EventCheckIn: [String] = []
    // talbe view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.EventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell2", for:indexPath) as! CheckInViewCell
        let Event: EventsOb
        let Maps: String
        Event = EventList[indexPath.row]
        Maps = Map[indexPath.row]
        cell.Name.text = Event.eventName
        cell.Location.text = Event.eventLocation
        cell.Detail.text = Event.eventDescription
        cell.Map.text = Maps
   
        
        return cell
    }
// when select the row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")

        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath) as! CheckInViewCell

        valueToPass = currentCell.Name.text
        valueToPass2 = currentCell.Location.text
        valueToPassDetail = currentCell.Detail.text
        valueToPassMap = currentCell.Map.text
        performSegue(withIdentifier: "CheckOut", sender: self)
    }
// pass data to detail check in class
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
           if(segue.identifier == "CheckOut"){
               let dest_vc = segue.destination as! DetailCheckIn
            dest_vc.location = self.valueToPass2
            dest_vc.detail = self.valueToPassDetail
            dest_vc.name = self.valueToPass
            dest_vc.map = self.valueToPassMap
            
  
           }
           
       }

   

    
    override func viewDidLoad() {
        myTableView.dataSource = self
        myTableView.delegate = self
        super.viewDidLoad()
        //reload table view
        self.myTableView.reloadData()
        MapButton.layer.cornerRadius = 10
//get data from firebase
        let ref = Database.database().reference()
        ref.child("Events").child("checkInUser").observe(DataEventType.value) { (snapshot) in
            self.EventList.removeAll()
          //get data from firbase
            if snapshot.exists(){
                let array:NSArray = snapshot.children.allObjects as NSArray
                for child in array {
                    let snap = child as! DataSnapshot
                    if snap.value is NSDictionary{
                        let data:NSDictionary = snap.value as! NSDictionary
                        if  let dict = data.value(forKey: mainInstance.name){
                            let dictName:NSDictionary = dict as! NSDictionary
                            let dictLocation:NSDictionary = dict as! NSDictionary
                            let dictDetail:NSDictionary = dict as! NSDictionary
                            let dictMap:NSDictionary = dict as! NSDictionary
                            let EventName = dictName["EventName"]
                            let Location = dictLocation["EventLocation"]
                            let Detail = dictDetail["EventDetail"]
                            let Map = dictMap["Map"]
                           
                            let myEvent = EventsOb(eventName: EventName as! String, eventLocation: Location as! String, eventDescription: Detail as! String)
                           // add data to event list and map
                            self.EventList.append(myEvent)
                            self.Map.append(Map as! String)
                            
                        }
                        
                    }
                }
                self.myTableView.reloadData()
            }
        }
    }
           

    //back to privious page
    @IBAction func BackButton(_ sender: Any) {
         navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    //back to map
    @IBAction func BackToMap(_ sender: Any) {
        performSegue(withIdentifier: "BackToMap", sender: self)
    }
    
}
