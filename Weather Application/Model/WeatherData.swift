//
//  WeatherData.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 15.11.2021.

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
