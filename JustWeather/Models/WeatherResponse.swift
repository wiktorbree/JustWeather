//
//  WeatherResponse.swift
//  JustWeather
//
//  Created by Wiktor Bramer on 16/05/2025.
//


import Foundation

struct WeatherResponse: Decodable {
    let main: WeatherTemp
    let weather: [Weather]
}
