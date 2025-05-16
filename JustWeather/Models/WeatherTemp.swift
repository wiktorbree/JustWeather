//
//  Weather.swift
//  JustWeather
//
//  Created by Wiktor Bramer on 15/05/2025.
//

import Foundation

struct WeatherTemp: Decodable {
    let temp: Double // We want temperature from main
    let feels_like: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
}
