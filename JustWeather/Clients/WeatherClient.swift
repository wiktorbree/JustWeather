//
//  WeatherClient.swift
//  JustWeather
//
//  Created by Wiktor Bramer on 15/05/2025.
//

import Foundation

struct WeatherClient {
    func fetchWeather(location: Location) async throws -> WeatherData {
        let (data, response) = try await URLSession.shared.data(from: APIEndpoint.endpointURL(for: .weatherByLatLon(location.lat, location.lon)))
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        guard let condition = weatherResponse.weather.first else {
            throw NetworkError.invalidData
        }
        
        
        return WeatherData(id: condition.id, temperature: weatherResponse.main.temp, feelsLike: weatherResponse.main.feels_like, main: condition.main, description: condition.description)
    }
}
