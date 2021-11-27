//
//  WeatherData.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 15.11.2021.

// Parse JSON from https://openweathermap.org/

struct WeatherData: Codable {
    let name: String
    let sys: Sys
    let main: Main
    let weather: [Weather]
    let visibility: Int
    let wind: Wind
    let dt: Int
    let timezone: Int
}

struct Sys: Codable {
    let country: String
}

struct Main: Codable {
    let temp: Double
    let pressure: Int
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
    let feels_like: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    //let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}
