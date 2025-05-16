//
//  WeatherData.swift
//  JustWeather
//
//  Created by Wiktor Bramer on 16/05/2025.
//

import Foundation

struct WeatherData {
    let id: Int
    let temperature: Double
    let feelsLike: Double
    let main: String
    let description: String
    
    var systemImageName: String {
        switch id {
            case 200...232:
                return "cloud.bolt.rain.fill"
            case 300...321:
                return "cloud.drizzle.fill"
            case 500...504:
                return "cloud.rain.fill"
            case 511:
                return "snowflake"
            case 520...531:
                return "cloud.heavyrain.fill"
            case 600...622:
                return "snow"
            case 701...771:
                return "cloud.fog.fill"
            case 781:
                return "tornado"
            case 800:
                return "sun.max.fill"
            case 801:
                return "cloud.sun.fill"
            case 802:
                return "cloud.fill"
            case 803...804:
                return "smoke.fill"
            default:
                return "questionmark"
        }
    }
}
