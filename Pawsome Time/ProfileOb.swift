//
//  ProfileOb.swift
//  Pawsome Time
//
//  Created by kwangi yu on 11/27/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//
// profile objects
import Foundation

class ProfileOb{
    //profile variables
    var name: String!
    var breed: String!
    var size: String!
    var personality: String!
    var dof: String!
    var url : String!
    //init for profile obj
    init (name: String, breed: String, size: String, personality: String, dof: String, url: String){
        self.name = name
        self.breed = breed
        self.size = size
        self.personality = personality
        self.dof = dof
        self.url = url
    }
}
