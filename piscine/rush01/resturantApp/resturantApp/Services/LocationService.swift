//
//  LocationService.swift
//  resturantApp
//
//  Created by Mohammad Butt on 10/18/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import Foundation
import CoreLocation

enum Result<T>
{
    case success(T)
    case failure(Error)
}

final class LocationService: NSObject
{
    private let manager: CLLocationManager
    
    init(manager: CLLocationManager = .init())
    {
        self.manager = manager
        super.init()
        manager.delegate = self
    }
    
    var newLocation: ((Result<CLLocation>) -> Void)?
    var dudChangeStatus: ((Bool) -> Void)?
    
    var status: CLAuthorizationStatus
    {
        return CLLocationManager.authorizationStatus()
    }
}


extension LocationService: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        newLocation?(.failure(error))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.sorted(by: {$0.timestamp > $1.timestamp}).first
        {
            newLocation?(.success(location))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        switch status
        {
        case .notDetermined, .restricted, .denied:
            didChangeSatus?(false)
        default:
            didChangeStatus?(true)
        }
    }
}
