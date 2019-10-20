//
//  NetworkService.swift
//  resturantApp
//
//  Created by Mohammad Butt on 10/19/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//

import Foundation
import Moya

//let path = ".yelpAPIKey.txt"
//lazy var hiddenAPI = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
/*
func read_file(_ : path) -> String
{
    //    let path = "myfile.txt"
    let contents = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
    
    return contents
}


private let apiKey = read_file(".privateYelpAPI.txt")
*/

private let apiKey = ""

enum YelpService
{
    enum BusinessesProvider: TargetType
    {
        case search(lat: Double, long: Double)
        case details(id: String)
        
        var baseURL: URL
        {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }
        
        var path: String
        {
            switch self
            {
            case .search:
                return "/search"
                
            case let .details(id):
                return "/\(id)"
            }
        }
        
        var method: Moya.Method
        {
            return .get
        }
        
        var sampleData: Data
        {
            return Data()
        }
        
        var task: Task
        {
            switch self
            {
            case let .search(lat, long):
                    return .requestParameters(parameters: ["latitude": lat, "longitude": long, "limit": 10], encoding: URLEncoding.queryString)
            
            case .details:
                return .requestPlain
                
            }
        }
        
        var headers: [String : String]?
        {
            return ["Authorization": "Bearer \(apiKey)"]
        }
    }
}
