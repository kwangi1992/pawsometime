//
//  EventsOb.swift
//  Pawsome Time
//
//  Created by kwangi yu on 11/27/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import Foundation
//Event Object 
class EventsOb{
    var eventLocation: String!
    var eventName: String!
    var eventDescription: String!
    // array of checked in users for the event
    var eventUserCheckIns : Array<Account> = []
    
    init(eventName: String, eventLocation: String, eventDescription: String){
        self.eventName = eventName
        self.eventLocation = eventLocation
        self.eventDescription = eventDescription
        
    }
    
    // function to display event contents
    func printEventsData() {
        print ("Event Name: " + self.eventName)
        print ("Event Location: " + self.eventLocation)
        print ("Event Description: " + self.eventDescription)
    }

    
}
