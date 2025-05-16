//
//  MeasurementFormatter+Extensions.swift
//  JustWeather
//
//  Created by Wiktor Bramer on 15/05/2025.
//

import Foundation

extension MeasurementFormatter {
    
    static func temperature(value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        
        let formatter = MeasurementFormatter()
        formatter.numberFormatter = numberFormatter
        
        let temp = Measurement(value: value, unit: UnitTemperature.kelvin)
        
        return formatter.string(from: temp)
    }
}
