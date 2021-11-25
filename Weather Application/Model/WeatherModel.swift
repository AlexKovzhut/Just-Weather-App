//
//  WeatherModel.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 15.11.2021.

import UIKit

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let countryName: String
    let main: String
    let description: String
    let temperature: Double
    let tempMax: Double
    let tempMin: Double
    let speed: Double
    let deg: Int
    let pressure: Int
    let humidity: Double
    let visibility: Int

    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }

    var conditionName: String {
        switch conditionId {
        case 200...232: return "cloud.bolt"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 701...781: return "cloud.fog"
        case 800: return "sun.max"
        case 801...804: return "cloud.bolt"
        default: return "cloud"
        }
    }
}
