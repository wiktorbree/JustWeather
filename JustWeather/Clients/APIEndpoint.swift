//
//  APIEndpoint.swift
//  JustWeather
//
//  Created by Wiktor Bramer on 15/05/2025.
//

import Foundation

// Provide endpoints (create URL)
enum APIEndpoint {
    
    static let baseURL = "https://api.openweathermap.org"
    
    case coordinatesByLocationName(String)
    case weatherByLatLon(Double, Double)
    
    // Private because we are exposing a different function to get the actual URL
    private var path: String {
        switch self { // self is a enum
        case .coordinatesByLocationName(let city):
            return "/geo/1.0/direct?q=\(city)&appid=\(Constants.Keys.weatherAPIKey)"
        case .weatherByLatLon(let lat, let lon):
            return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.Keys.weatherAPIKey)"
        }
    }
    
    static func endpointURL(for endpoint: APIEndpoint) -> URL {
        let endpointPath = endpoint.path
        return URL(string: baseURL + endpointPath)! // this is getting the actual URL
    }
    
}
