//
//  ReverseGeocodingClient.swift
//  JustWeather
//
//  Created by Wiktor Bramer on 16/05/2025.
//

import Foundation
import CoreLocation

struct ReverseGeocodingClient {
    func cityName(from location: CLLocation) async -> String {
        let geocoder = CLGeocoder()
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                return placemark.locality ?? "Your Location"
            }
        } catch {
            print("Reverse geocoding failed: \(error)")
        }
        return "Your Location"
    }
}
