//
//  CurrentWeatherData.swift
//  Just Weather App
//
//  Created by Alexander Kovzhut on 05.07.2021.
//
import Foundation

struct CurrentWeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let name: String
}

struct Main: Codable {
    let temp, feelsLike: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
    }
}

struct Sys: Codable {
    let country: String
}

struct Weather: Codable {
    let id: Int
    let weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case id
        case weatherDescription = "description"
    }
}

struct Wind: Codable {
    let speed: Double
}

