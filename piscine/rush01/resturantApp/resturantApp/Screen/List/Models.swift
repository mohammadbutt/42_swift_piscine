//
//  Models.swift
//  resturantApp
//
//  Created by Mohammad Butt on 10/19/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//
// Credits: Gary Tokman www.youtube.com/playlist?list=PLgwcD-3WBz9lQ5NgVon61nEiFRoxs5kAT

import Foundation
import CoreLocation

struct Root: Codable
{
    let businesses: [Business]
}

struct Business: Codable
{
    let id: String
    let name: String
    let imageUrl: URL
    let distance: Double
    
}


struct ResturantListViewModel
{
    let name: String
    let imageUrl: URL
    let distance: String
    let id: String
}

extension ResturantListViewModel
{
    init(business: Business)
    {
        self.name = business.name
        self.id = business.id
        self.imageUrl = business.imageUrl
        
//        self.distance = "\(business.distance / 1609.344)" // Converts meters into miles
        self.distance = String(format: "%.2f miles", business.distance/1609.344)
    }
}


struct Details: Decodable
{
    let price: String
    let phone: String
    let isClosed: Bool
    let rating: Double
    let name: String
    let photos: [URL]
    let coordinates: CLLocationCoordinate2D
}

extension CLLocationCoordinate2D: Decodable
{
    enum CodingKeys: CodingKey
    {
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }
}

struct DetailsViewModel
{
    let name: String
    let price: String
    let isOpen: String
    let phoneNumber: String
    let rating: String
    let imageUrls: [URL]
    let coordinate: CLLocationCoordinate2D
}

extension DetailsViewModel
{
    init(details: Details)
    {
        self.name = details.name
        self.price = details.price
        self.isOpen = details.isClosed ? "Closed" : "Open"
        self.phoneNumber = details.phone
        self.rating = "\(details.rating) / 5.0"
        self.imageUrls = details.photos
        self.coordinate = details.coordinates
    }
}





