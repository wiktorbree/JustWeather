//
//  ContentView.swift
//  JustWeather
//
//  Created by Wiktor Bramer on 15/05/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var city: String = ""
    @State private var isFetchingWeather: Bool = false
    @State private var cityText: String = ""
    
    @StateObject private var locationManager: LocationManager = LocationManager()
    
    let geocodingClient = GeocodingClient()
    let weatherClient = WeatherClient()
    let reverseGeocodingClient = ReverseGeocodingClient()
    
    @State private var weather: WeatherData?
    
    private func fetchWeather(location: Location) async {
        do {
            weather = try await weatherClient.fetchWeather(location: location)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                TextField("Enter city name...", text: $city)
                    
                    .onSubmit {
                        isFetchingWeather = true
                    }.task(id: isFetchingWeather) {
                        if isFetchingWeather {
                            do {
                                if let location = try await geocodingClient.coordinateByCity(city) {
                                    await fetchWeather(location: location)
                                    cityText = city
                                }
                            } catch {
                                print("Error fetching coordinates: \(error)")
                            }
                            isFetchingWeather = false
                            city = ""
                        }
                    }
                    .task(id: locationManager.location) {
                        if let loc = locationManager.location {
                            let location = Location(name: "", lat: loc.coordinate.latitude, lon: loc.coordinate.longitude)
                            await fetchWeather(location: location)
                            cityText = await reverseGeocodingClient.cityName(from: loc)
                        }
                    }
            }
            .fontDesign(.monospaced)
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(Color(.second))
            .clipShape(Capsule(style: .continuous))
            
            if let weather {
                Spacer()
                Text(cityText)
                    .font(.system(size: 30, weight: .bold, design: .monospaced))
                    .padding()
                Spacer()
                Image(systemName: weather.systemImageName)
                    .font(.system(size: 90))
                    .padding()
                    .symbolEffect(.bounce.up.byLayer, options: .repeat(.continuous))
                Text(MeasurementFormatter.temperature(value: weather.temperature))
                    .font(.system(size: 90, design: .monospaced))
                HStack {
                    Text("Feels like:")
                    Text(MeasurementFormatter.temperature(value: weather.feelsLike))
                }.font(.system(size: 20, design: .monospaced))
                    .foregroundStyle(Color(.secondaryFont))
                Text(weather.main)
                    .font(.system(size: 20, design: .monospaced))
                    .foregroundStyle(Color(.font))
                    .padding(.top, 15)
                Text(weather.description)
                    .font(.system(size: 15, design: .monospaced))
                    .foregroundStyle(Color(.font))
                Spacer()
            } else {
                Spacer()
                Text("Allow location or enter city")
                    .font(.system(size: 30, design: .monospaced))
                    .foregroundStyle(.font)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .foregroundStyle(.font)
        .background(Color(.background))
        .onAppear() {
            locationManager.requestLocation()
        }
    }
}

#Preview {
    ContentView()
}
