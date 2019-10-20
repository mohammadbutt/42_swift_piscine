//
//  AppDelegate.swift
//  resturantApp
//
//  Created by Mohammad Butt on 10/18/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import UIKit
import Moya
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    let window = UIWindow()
    let locationService = LocationService()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let service = MoyaProvider<YelpService.BusinessesProvider>()
    let jsonDecoder = JSONDecoder()
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
/*
        service.request(.details(id: "WavvLdfdP6g8aZTtbBQHTw"))
        {
            (result) in
            switch result
            {
            case .success(let response):
                let details = try? self.jsonDecoder.decode(Details.self, from: response.data)
                print("Details:\n\n \(details)")
            case .failure(let error):
                print("Failed to get details \(error)")
            }
        }
*/
/*
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase // converts pythonic snake_case into camelCase
        locationService.didChangeStatus =
            {
                [weak self] success in
                if success
                {
                    self?.locationService.getLocation()
                }
            }
        locationService.newLocation =
            {
                [weak self] result in
                switch result
                {
                case .success(let location):
                    self?.loadBusinesses()
                case .failure(let error):
                    assertionFailure("Error getting the users location\(error)")
                }
            }
 */
 // Pasting below this
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        locationService.didChangeStatus =
            {
                [weak self] success in
                if success
                {
                    self?.locationService.getLocation()
                }
        }
        
        locationService.newLocation =
            {
                [weak self] result in
                switch  result
                {
                case .success(let location):
                    self?.loadBusinesses(with: location.coordinate)
//                    print(location)
                case .failure(let error):
                    assertionFailure("Error getting the users location \(error)")
                }
        }
// Pasting above this
        // Override point for customization after application launch.
        
        switch locationService.status
        {
        case .notDetermined, .denied, .restricted:
            let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
            locationViewController?.delegate = self
//            locationViewController?.locationService = locationService
            window.rootViewController = locationViewController
        default:
            let nav = storyboard.instantiateViewController(withIdentifier: "ResturantNavigationController") as? UINavigationController
            self.navigationController = nav
            window.rootViewController = nav
            locationService.getLocation()
            (nav?.topViewController as? ResturantTableViewController)?.delegate = self
//            loadBusinesses()
 //           print("Failed to load location i")
 //           assertionFailure()
        }
        window.makeKeyAndVisible()
        return true
    }
    
    private func loadDetails(for viewController:UIViewController, withId id: String)
    {
        service.request(.details(id: id))
        {
            [weak self] (result) in
            switch result
            {
            case .success(let response):
                guard let strongSelf = self else { return }
               if let details = try? strongSelf.jsonDecoder.decode(Details.self, from: response.data)
               {
//                print("Details:\n\n \(details)")
                    let detailsViewModel = DetailsViewModel(details: details)
                    (viewController as? DetailsFoodViewController)?.viewModel = detailsViewModel
//                    (strongSelf.navigationController?.topViewController as? DetailsFoodViewController)?.viewModel = detailsViewModel
                }
            case .failure(let error):
                print("Failed to get details \(error)")
            }
        }
    }
    
    private func loadBusinesses(with coordinate: CLLocationCoordinate2D)
    {
 //       service.request(.search (lat: 37.570950, long: -122.050613))
 //       service.request(.search(lat: coordinate.latitude, long: coordinate.longitude))
        service.request(.search(lat: 37.570950, long: -122.050613)) // Change this to different coordinates to see different results
        {
            [weak self] (result) in
            guard let strongSelf = self else { return }

            switch result
            {
            case .success(let response):
//                guard let strongSelf = self else { return }
                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
                let viewModels = root?.businesses.compactMap(ResturantListViewModel.init)
                    .sorted(by: {$0.distance < $1.distance})
                //                print(root)
            //                print(try? JSONSerialization.jsonObject(with: response.data, options: []))
            if let nav = strongSelf.window.rootViewController as? UINavigationController,
                let resturantListViewController = nav.topViewController as? ResturantTableViewController
                {
                    resturantListViewController.viewModels = viewModels ?? []
                }
            else if let nav = strongSelf.storyboard.instantiateViewController(withIdentifier: "ResturantNavigationController") as? UINavigationController
            {
                strongSelf.navigationController = nav
                strongSelf.window.rootViewController?.present(nav, animated: true)
                {
                
//                window.rootViewController = nav
//                locationService.getLocation()
                    (nav.topViewController as? ResturantTableViewController)?.delegate = self
                    (nav.topViewController as? ResturantTableViewController)?.viewModels = viewModels ?? []

                }
            }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

extension AppDelegate: LocationActions, ListActions
{
    func didTapAllow()
    {
        locationService.requestLocationAuthorization()
    }
    func didTapCell(_ viewController: UIViewController, viewModel: ResturantListViewModel)
    {
        loadDetails(for: viewController, withId: viewModel.id)
    }
/*
    func didTapCell(_ viewModel: ResturantListViewModel)
    {
        loadDetails(withId: viewModel.id)
    }
 */
}
/*
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
*/
