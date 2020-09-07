//
//  CheckInUsers.swift
//  Pawsome Time
//
//  Created by kwangi yu on 12/8/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import Firebase


class CheckInUsers: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var map: String!
    var name: String!
    //var profile: ProfileOb
    var profileList : [ProfileOb] = []

    @IBOutlet var myTable: UITableView!
    
    
    //custom table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profileList.count
    }
    //custom table view to show check in user list, profile photo and profile
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "myCell3", for:indexPath) as! TableForCheckInUsers
        
         let dog = profileList[indexPath.row]
        let imageUrl = URL(string: dog.url)
        let imageData = try! Data(contentsOf: imageUrl!)
        cell.ProfilePhoto.image = UIImage(data : imageData)
        cell.dogName.text = dog.name
        cell.breed.text = dog.breed
        cell.size.text = dog.size
        cell.birth.text = dog.dof
       cell.Personality.text = dog.personality
        
         
         return cell
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    
    
    
    override func viewDidLoad() {
        myTable.dataSource = self
        myTable.delegate = self
        super.viewDidLoad()
        let ref = Database.database().reference()
        //get data from fire base check in user and show to talbe view
        
        ref.child("Events").child(map).child(name).child("checkIn").observe(DataEventType.value) {(snapshot) in
            self.profileList.removeAll()
            for child in (snapshot.children){
                let snap = child as! DataSnapshot
                let dict = snap.value as! NSDictionary
                              
                let birth = dict["Birth"] as? String ?? ""
                let name = dict["DogName"] as? String ?? ""
                let personality = dict["Personality"] as? String ?? ""
                let size = dict["Size"] as? String ?? ""
                let url = dict["url"] as? String ?? ""
                let breed = dict["Breed"] as? String ?? ""
                let profile = ProfileOb.init(name: name, breed: breed, size: size, personality: personality, dof: birth, url: url)
                print(profile.name)
                print(profile.breed)
                self.profileList.append(profile)
            
                print(self.profileList)
             }
            self.myTable.reloadData()
        }

        
    }
    //back to privious page
    @IBAction func BackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
  

}
