//
//  EditProfile.swift
//  Pawsome Time
//
//  Created by kwangi yu on 11/23/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
class EditProfile: UIViewController {
    //image picker
    var picker: UIImagePickerController!
    var urlImage: String?
        
        
    
        
    

    @IBOutlet var updatebutton: UIButton!
    @IBOutlet var Breed: UITextField!
    @IBOutlet var Size: UITextField!
    @IBOutlet var Name: UITextField!
    @IBOutlet var Personality: UITextField!
    @IBOutlet var Dof: UITextField!
    @IBOutlet var Image: UIImageView!
    @IBOutlet var AddImage: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        //image picker
        picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        //button shape
        updatebutton.layer.cornerRadius = 10
        //data base from firebase
        let ref = Database.database().reference()
                      ref.child("userid").child(mainInstance.name).child("profile").observeSingleEvent(of: .value, with: { snapshot in
                          
                          for child in (snapshot.children){
                              //get snapshot data from firebase about profile + image
                              let snap = child as! DataSnapshot
                              
                              let dict = snap.value as! [String: String]
                              
                              let Dogname = dict["DogName"]
                              
                              let breed = dict["Breed"]
                              
                              let size = dict["Size"]
                              
                              let dof = dict["dof"]
                              
                              let personality = dict["Personality"]
                              
                              let imageUrlString = dict["PhotoUrl"]
                              
                                  let imageUrl = URL(string: imageUrlString!)

                                  let imageData = try! Data(contentsOf: imageUrl!)

                                  
                              
                              
                                  self.Dof.text = dof
                                  self.Personality.text = personality
                                  self.Size.text = size
                                  self.Name.text = Dogname
                                  self.Breed.text = breed
                                  self.Image.image = UIImage(data: imageData)
                    
                            
                        }})

        
}
    //Add image
    @IBAction func addAction(_ sender: Any) {

        let alert =  UIAlertController(title: "Photo", message: "from where", preferredStyle: .actionSheet)

// image from library
        let library =  UIAlertAction(title: "Library", style: .default) { (action) in self.openLibrary()

        }

// imag from camera
        let camera =  UIAlertAction(title: "Camera", style: .default) { (action) in

        self.openCamera()

        }

// cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)


        alert.addAction(library)

        alert.addAction(camera)

        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)



        
        
        
    }
    func openLibrary(){
// library
      picker.sourceType = .photoLibrary

      present(picker, animated: false, completion: nil)

    }
// open camera
    func openCamera(){

      if(UIImagePickerController .isSourceTypeAvailable(.camera)){

      picker.sourceType = .camera

                  present(picker, animated: false, completion: nil)

              }

              else{

                  print("Camera not available")

              }



    }
// update profile
    @IBAction func updateprofile(_ sender: Any) {
        //get info from user, image
        mainInstance.birth = self.Dof.text!
        mainInstance.dog = self.Name.text!
        mainInstance.personal = self.Personality.text!
        mainInstance.size = self.Size.text!
        mainInstance.breed = self.Breed.text!
        guard let image = Image.image else { return}
        var myProfile = ProfileOb(name: self.Name.text!, breed: self.Breed.text!, size: self.Size.text!, personality: self.Personality.text!, dof: self.Dof.text!, url: "")

        let ref = Database.database().reference()
        
        let storageRef = Storage.storage().reference().child("user").child(mainInstance.name)
        
     //upload image that receive from user
        if let uploadData = image.jpegData(compressionQuality: 0.5){
            print("success")
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
           storageRef.putData(uploadData, metadata: nil, completion:{ (metadata, error) in
            guard let metadata = metadata else{
                print(error)
                return
            }
            storageRef.downloadURL { (url, error) in
                if let error = error{
                    print(error)
                }
                
                guard let url = url?.absoluteString else {
                print(error)
                return
              }
                print(url)
                // save profile + image URL to Firebase
            ref.child("userid").child(mainInstance.name).child("profile").child("profileChildren").setValue(["DogName" : myProfile.name, "Breed" : myProfile.breed, "Size" : myProfile.size, "Personality" : myProfile.personality, "dof" : myProfile.dof, "PhotoUrl" : url])
                mainInstance.url = url
                
                
            }
            
           })
            
            
        }
        else{
            //errorcheck
            print("wrong")
        }
        // back to privious page
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
  

    }
    //back to privious
    @IBAction func BackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
  

}
// extention for image picker
extension EditProfile : UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{

            self.Image.image = image

                print(info)

            }

            dismiss(animated: true, completion: nil)

        }

}
