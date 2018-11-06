//
//  ViewController.swift
//  Maps
//
//  Created by Rana Rauf on 12/29/15.
//  Copyright © 2015 X-Techs. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var lattitude:Double = 0.0
    var longitude:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        UIApplication.shared.isIdleTimerDisabled = true
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        labelSpeed.transform = CGAffineTransformMakeScale(1, -1)
        labelHUSpeed.transform = CGAffineTransform(scaleX: 1, y: -1)
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
/*
        
        
        let lattitude:CLLocationDegrees = 41.74
        let longitude:CLLocationDegrees = -88.22
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
        
        let deltaLat:CLLocationDegrees = 0.01
        let deltaLon:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: deltaLat, longitudeDelta: deltaLon)
        
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        
        map.setRegion(region, animated: true)
*/
        
    }

    @IBOutlet var labelLattitude: UILabel!
    
    @IBOutlet var labelLongitude: UILabel!
    
    @IBOutlet var labelSpeed: UILabel!
    
    @IBOutlet var labelCourse: UILabel!
    
    @IBOutlet var labelAltitude: UILabel!
    @IBOutlet weak var labelAddress1: UILabel!
    @IBOutlet weak var labelCity: UILabel!
//    @IBOutlet weak var labelState: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
//    @IBOutlet weak var labelZip: UILabel!
    
    @IBOutlet weak var labelHUSpeed: UILabel!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func copyAddressButton(_ sender: AnyObject) {
        if labelAddress1.text != nil && labelCity.text != nil && labelCountry != nil {
            UIPasteboard.general.string = labelAddress1.text! + " " + labelCity.text! + " " + labelCountry.text!
        }
    }
    
    @IBOutlet weak var copyCoordinatesButton: UIButton!
    @IBAction func copyCoordinatesAction(_ sender: AnyObject) {
        if labelLattitude.text != nil && labelLongitude != nil {
            UIPasteboard.general.string = String(lattitude) + ", " + String(longitude)
        }
        
    }
    
//    func hourToString(hour:Double) -> String {
//        let hours = Int(floor(hour))
//        let mins = floor(hour * 60) % 60
////        let mins = Int(floor(hour * 60) % 60)
////        let secs = Int(floor(hour * 3600) % 60)
//        
//        return String(format:"%d:%02d:%02d", hours, mins, secs)
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let centerLocation = locations[0]
        //print(centerLocation)
        
        
        lattitude = centerLocation.coordinate.latitude
        longitude = centerLocation.coordinate.longitude
        
//        print(lattitude)
//        print(longitude)
//        
        let speed = centerLocation.speed
        
        let course = centerLocation.course
        let altitude = centerLocation.altitude
        
//        CLGeocoder().reverseGeocodeLocation(centerLocation, completionHandler:
//            {(placemarks, error) in
//                if (error != nil) {
////                    print("reverse geodcode fail:")
//                    print(error)
//                } else {
//                    
//                    var addressString: String=""
//                    
//                    let pm = placemarks! as [CLPlacemark]
//                    
//                    let placemark = pm[0]
//                
//                    if placemark.subThoroughfare != nil {
//                        addressString = placemark.subThoroughfare! + " "
//                    }
//                    if placemark.thoroughfare != nil {
//                        addressString = addressString + placemark.thoroughfare! + ", "
//                    }
//                    if placemark.locality != nil {
//                        addressString = addressString + placemark.locality! + ", "
//                    }
//                    if placemark.administrativeArea != nil {
//                        addressString = addressString + placemark.administrativeArea! + " "
//                    }
//                    if placemark.postalCode != nil {
//                        addressString = addressString + placemark.postalCode! + " "
//                    }
//                    if placemark.country != nil {
//                        addressString = addressString + placemark.country!
//                    }
//                    
//                    print(addressString)
//                    self.labelAddress.text = addressString
//                }
        
                
                
                
//                if pm.count > 0 { self.showAddPinViewController(placemarks[0] as CLPlacemark) }

        
//        })
        
        
//        print(String(lattitude))
//        print(String(longitude))
        
        
        CLGeocoder().reverseGeocodeLocation(centerLocation) { (placemarks, error) in
            if error != nil {
                print("geocoder reqeust failed")
            } else {
//                var addressString: String=""
                
                let pm = placemarks! as [CLPlacemark]
                
                let placemark = pm[0]
                
                self.labelAddress1.text = ""
                
                if placemark.subThoroughfare != nil {
//                  self.labelAddress1.text = placemark.subThoroughfare! + " " + placemark.thoroughfare!
                    self.labelAddress1.text = self.labelAddress1.text! + placemark.subThoroughfare!
                }

                if placemark.thoroughfare != nil {
                    self.labelAddress1.text = self.labelAddress1.text! + " " + placemark.thoroughfare!
                }
                
//                if placemark.locality != nil {
//                    self.labelCity.text = placemark.locality! + ", " + placemark.administrativeArea! + " " + placemark.postalCode!
//                }
                
                self.labelCity.text = ""
                
                if placemark.locality != nil {
                    self.labelCity.text = self.labelCity.text! +  placemark.locality!
                }
                
                if placemark.administrativeArea != nil {
                    self.labelCity.text = self.labelCity.text! + ", " + placemark.administrativeArea!
                }
                
                if placemark.postalCode != nil {
                    self.labelCity.text = self.labelCity.text! + " " + placemark.postalCode!
                }
                
                
//                if placemark.administrativeArea != nil {
//                    self.labelState.text = placemark.administrativeArea!
//                }
//                if placemark.postalCode != nil {
//                    self.labelZip.text = placemark.postalCode!
//                }
                if placemark.country != nil {
                    self.labelCountry.text = placemark.country!
                }
                
                //print(addressString)
                
            }
        }
        var strSpeed: String=""
        
        if speed > 0 {
            strSpeed = String(60/(round(speed * 360 * 0.62137)/100)) // miles
            labelHUSpeed.text = String(Int(round(speed * 3.6 * 0.62137))) // miles
        }
        else
        {
            strSpeed = "0"
            labelHUSpeed.text = "0"
        }
        labelLattitude.text = String(lattitude)
        labelLongitude.text = String(longitude)
        labelSpeed.text = strSpeed // String(60/(round(speed * 360 * 0.62137)/100)) // miles
        
//        labelSpeed.text = String(round(speed * 360 * 1)/100) // kilometers
//        labelHUSpeed.text = String(Int(round(speed * 3.6 * 1))) // kilometers
        labelCourse.text = String(course)
        labelAltitude.text = String(round(altitude * 0.9144 * 3.0)) // feet
//        labelAltitude.text = String(round(100 * altitude/1000)) // kilometers
        
        
    }

}

