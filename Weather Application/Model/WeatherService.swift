//
//  WeatherService.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 15.11.2021.
//
import CoreLocation

enum ServiceError: Error {
    case network(statusCode: Int)
    case parsing
    case general(reason: String)
}

protocol WeatherServiceDelegate: AnyObject {
    func didFetchWeather(_ weatherService: WeatherService, _ weather: WeatherModel)
    func didFailWithError(_ weatherService: WeatherService, _ error: ServiceError)
}

struct WeatherService {
    var delegate: WeatherServiceDelegate?
    
    //https://api.openweathermap.org/data/2.5/onecall?lat=59.9&lon=30.3&exclude=current&appid=98968b07c1dd9f318c47c889e6b070ec&units=metric&lang=en

    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=98968b07c1dd9f318c47c889e6b070ec&units=metric"

    func fetchWeather(cityName: String) {
        guard let urlEncodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            assertionFailure("Could not encode city named: \(cityName)")
            return
        }

        let urlString = "\(weatherURL)&q=\(urlEncodedCityName)"
        performRequest(with: urlString)
    }

    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        // Create a URL
        let url = URL(string: urlString)!
        // Create a URLSession
        let session = URLSession(configuration: .default)
        // Give the session a task
        let task = session.dataTask(with: url) {data, responce, error in

            guard let unwrapedData = data, let httpResponce = responce as? HTTPURLResponse else {
                return
            }

            guard error == nil else {
                DispatchQueue.main.async {
                    let generalError = ServiceError.general(reason: "Check network availability")
                    self.delegate?.didFailWithError(self, generalError)
                }
                return
            }

            guard (200...299).contains(httpResponce.statusCode) else {
                DispatchQueue.main.async {
                    self.delegate?.didFailWithError(self, ServiceError.network(statusCode: httpResponce.statusCode))
                }
                return
            }

            guard let weather = self.parseJSON(unwrapedData) else { return }

            DispatchQueue.main.async {
                self.delegate?.didFetchWeather(self, weather)
            }
        }
        //Start the task
        task.resume()
    }

    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        guard let decodedData = try? JSONDecoder().decode(WeatherData.self, from: weatherData) else {
            DispatchQueue.main.async {
                self.delegate?.didFailWithError(self, ServiceError.parsing)
            }
            return nil
        }

        let id = decodedData.weather[0].id
        let temperature = decodedData.main.temp
        let cityName = decodedData.name

        let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temperature)

        return weather
    }
}
