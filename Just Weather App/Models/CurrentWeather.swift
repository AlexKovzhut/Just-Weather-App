//
//  CurrentWeather.swift
//  Just Weather App
//
//  Created by Alexander Kovzhut on 05.07.2021.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    let countryName: String
    
    let temp: Double
    var tempString: String {
        return String(format: "%.0f", temp)
    }
    
    let tempFeelsLike: Double
    var tempFeelsLikeString: String {
        return String(format: "%.0f", tempFeelsLike)
    }
    
    let pressure: Int
    var pressureString: String {
        return "\(pressure)"
    }
        
    let humidity: Int
    var humidityString: String {
        return "\(humidity)"
    }
    
    let windSpeed: Double
    var windSpeedString: String {
        return "\(windSpeed.rounded())"
    }
    
    let id: Int
    var systemIconNameString: String {
        switch id {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    let weatherDescription: String
    
    init?(currentWeatherData: CurrentWeatherData ) {
        cityName = currentWeatherData.name
        countryName = currentWeatherData.sys.country
        temp = currentWeatherData.main.temp
        tempFeelsLike = currentWeatherData.main.feelsLike
        pressure = currentWeatherData.main.pressure
        humidity = currentWeatherData.main.humidity
        windSpeed = currentWeatherData.wind.speed
        id = currentWeatherData.weather.first!.id
        weatherDescription = currentWeatherData.weather.first!.weatherDescription
    }
    
    
}
