//
//  ViewController.swift
//  ex01WhereAmI
//
//  Created by Mohammad Butt on 10/18/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//
// Exercise 01: Where AM I?
// Reference: www.youtube.com/watch?v=WDrdtdMYgWc

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate
{
    
    // Same steps as ex00 to get the map on the storyboard
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("location = \(locValue.latitude) \(locValue.longitude)")
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegionMakeWithDistance((userLocation?.coordinate)!, 600, 600)
        
        // 600, 600 determines how much it should zoom, 6, 6 will zoom in more.
        
        self.map.setRegion(viewRegion, animated: true)
    }
}

