//
//  ViewMap.swift
//  Pawsome Time
//
//  Created by kwangi yu on 11/23/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
class ViewMap: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    //logi lati variable
    var logi: Double?
    var lati: Double?
    @IBOutlet var HomeButton: UIButton!
    
   
    override func viewDidLoad(){
        
        super.viewDidLoad()
        //button shape
        HomeButton.layer.cornerRadius = 10
        //get location data from firebase and show to map kit
        let ref = Database.database().reference()
        ref.child("locations").observe(DataEventType.value){ (snapshot) in
                    let allAnnotations = self.mapView.annotations
                    self.mapView.removeAnnotations(allAnnotations)
                    // iterate through database
                    for child in (snapshot.children) {
                        
                        // make each child a snapshot
                        let snap = child as! DataSnapshot
                        
                        // value is dict
                        let dict = snap.value as! [String: Double]
                        
                        // get the values in variables
                        let longitude = dict["longitude"]
                        let lagitude = dict["lagitude"]

                        let annotation = MKPointAnnotation()
                        let coordinate = CLLocationCoordinate2D(latitude: lagitude ?? 0 , longitude: longitude ?? 0 )
                        annotation.coordinate = coordinate
                        
                        self.mapView.addAnnotation(annotation)
                            
                            
                        
                        

                        
                    }
         
                    
        }
        
        
        
        
        // user's location
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
 
        mapView.delegate = self
        // long tap
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        mapView.addGestureRecognizer(longTapGesture)
        mapView.register(ViewMap.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    @objc func longTap(sender: UIGestureRecognizer){
        print("long tap")
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            let ref = Database.database().reference()
            let longitude = locationOnMap.longitude
            let lagitude = locationOnMap.latitude
            //save location data logi and lati to firebase
            ref.child("locations").childByAutoId().setValue(["longitude" : longitude, "lagitude" : lagitude]);
            
            addAnnotation(location: locationOnMap)
        }
    }
    //Add annotion to map
    func addAnnotation(location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Event"
        annotation.subtitle = "Event"


        
        self.mapView.addAnnotation(annotation)
    }
    

//pin set
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { print("fail mkpointannotaions"); return nil }

        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .infoLight)
            pinView!.pinTintColor = UIColor.red
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
// call out tap to move event list
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("tapped on pin ")
        logi = view.annotation?.coordinate.latitude
        lati = view.annotation?.coordinate.longitude
        print (logi)
        print (lati)
        print ("check")
        self.performSegue(withIdentifier: "EventList", sender: self)

        
    }
    //send data to eventlist
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "EventList"){
            var vc = segue.destination as! EventListLocation
            vc.lati = lati
            vc.logi = logi
            
            
    }
    }
//call out
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let doSomething = view.annotation?.title! {
               print("do something")
               self.performSegue(withIdentifier: "EventList", sender: self)
                
            }
        }

        
      }
//back button move to privious page
    @IBAction func BackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
    
    //home button move to home
    @IBAction func HomeButton(_ sender: Any) {
        self.performSegue(withIdentifier: "BackToMain", sender: self)
    }
}
