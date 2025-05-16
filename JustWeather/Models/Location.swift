//
//  Location.swift
//  JustWeather
//
//  Created by Wiktor Bramer on 15/05/2025.
//

import Foundation

struct Location: Decodable { // Match names with the json file from API!! (json file is returning an array -> [] )
    let name: String
    let lat: Double
    let lon: Double
}
