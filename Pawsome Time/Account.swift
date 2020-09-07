//
//  Account.swift
//  Pawsome Time
//
//  Created by kwangi yu on 11/27/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import Foundation
import UIKit
// account class but may not use
class Account{
    var accountid: String!
    var accountpw: String!
    var profile: Profile!
    var email: String!
    var eventslist : Array<EventsOb> = []
    
    init(accountid: String, accountpw: String, email: String) {
        self.accountid = accountid
        self.accountpw = accountpw
        self.email = email
    }
    
    // test function to make sure data is being passed
    func checkIfHere() {
        print ("ID: " + self.accountid)
        print ("PW: " + self.accountpw)
        print ("email: " + self.email)
    }
    
    
}


