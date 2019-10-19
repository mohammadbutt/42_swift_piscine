//
//  LocationViewController.swift
//  resturantApp
//
//  Created by Mohammad Butt on 10/18/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController
{
    
    @IBOutlet weak var locationView: LocationView!
    var locationSerivce: LocationService?
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        locationView.didTapAllow =
            {
                [weak self] in
//                print("tapped allow")
                self?.locationSerivce?.requestLocationAuthorization()
            }
        
        locationSerivce?.didChangeStatus =
            {
                [weak self] success in
                if success
                {
                    self?.locationSerivce?.getLocation()
                }
            }
        
        locationSerivce?.newLocation =
            {
                [weak self] result in
                switch  result
                {
                case .success(let location):
                    print(location)
                case .failure(let error):
                    assertionFailure("Error getting the users location \(error)")
                }
            }
    }
    
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
