//
//  WeatherService.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 15.11.2021.
//

struct Weather {
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        String(format: "%.0f", temperature)
    }
}

protocol WeatherServiceDelegate: AnyObject {
    func didFetchWeather(_ weatherService: WeatherService, weather: Weather)
}

struct WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    func fetchWeather(cityName: String) {
        let weather = Weather(cityName: "London", temperature: 29)
        delegate?.didFetchWeather(self, weather: weather)
    }
}
