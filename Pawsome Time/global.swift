//
//  global.swift
//  Pawsome Time
//
//  Created by kwangi yu on 12/4/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import Foundation
//global variable set up
class Main {
  var name:String
    var dog: String
    var birth: String
    var personal: String
    var url: String
    var size: String
    var breed: String
    
    init(name:String, dog: String, birth: String, personal: String, url:String, size: String, breed: String) {
    self.name = name
        self.dog = dog
        self.birth = birth
        self.personal = personal
        self.url = url
        self.size = size
        self.breed = breed
  }
}

func setName(name:String){
    mainInstance.name = name
}

func setProfile(dogname: String, dogbirth: String, personality: String){
    mainInstance.dog = dogname
    mainInstance.birth = dogbirth
    mainInstance.personal = personality
}
//global variable 
var mainInstance = Main(name:"My Global Class", dog: "dog", birth: "birth", personal: "personality", url: "url", size: "size", breed: "breed")

