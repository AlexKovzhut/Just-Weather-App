//
//  WeatherService.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 15.11.2021.
//
import CoreLocation

//enum ServiceError: Error {
//    case network(statusCode: Int)
//    case parsing
//    case general(reason: String)
//}
//
//protocol WeatherServiceDelegate: AnyObject {
//    func didFetchWeather(_ weatherService: WeatherService, _ weather: WeatherModel)
//    func didFailWithError(_ weatherService: WeatherService, _ error: ServiceError)
//}
//
//struct WeatherService {
//    var delegate: WeatherServiceDelegate?
//
//    let weatherURL = URL(string:"")!
//
//    func fetchWeather(cityName: String) {
//        guard let urlEncodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
//            assertionFailure("Could not encode city named: \(cityName)")
//            return
//        }
//
//        let urlString = "\(weatherURL)&q=\(urlEncodedCityName)"
//        performRequest(with: urlString)
//    }
//
//    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let urlString = "\(weatherURL)&latitude=\(latitude)&longitude=\(longitude)"
//        performRequest(with: urlString)
//    }
//
//    func performRequest(with urlString: String) {
//        let url = URL(string: urlString)!
//        let task = URLSession.shared.dataTask(with: url) {data, responce, error in
//            guard let unwrapedData = data, let httpResponce = responce as? HTTPURLResponse else {
//                return
//            }
//
//            guard error == nil else {
//                DispatchQueue.main.async {
//                    let generalError = ServiceError.general(reason: "Check network availability")
//                    self.delegate?.didFailWithError(self, generalError)
//                }
//                return
//            }
//
//            guard (200...299).contains(httpResponce.statusCode) else {
//                DispatchQueue.main.async {
//                    self.delegate?.didFailWithError(self, ServiceError.network(statusCode: httpResponce.statusCode))
//                }
//                return
//            }
//
//            guard let weather = self.parseJSON(unwrapedData) else {
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.delegate?.didFetchWeather(self, weather)
//            }
//        }
//        task.resume()
//    }
//
//    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
//        guard let decodedData = try? JSONDecoder().decode(WeatherData.self, from: weatherData) else {
//            DispatchQueue.main.async {
//                self.delegate?.didFailWithError(self, ServiceError.parsing)
//            }
//            return nil
//        }
//
//        let id = decodedData.weather[0].id
//        let temperature = decodedData.main.temperature
//        let name = decodedData.name
//
//        let weather = WeatherModel(conditionId: id, cityName: name, temperature: temperature)
//
//        return weather
//    }
//}

struct WeatherService {
    let weatherURL = ""
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        print(urlString)
    }
    
    func performRequest(with urlString: String) {
        // Create a URL
        if let url = URL(string: urlString) {
            // Create a URLSession
            let session = URLSession(configuration: .default)
            // Give the session a task
            let task = session.dataTask(with: url) { data, responce, error in
                
            }
            // Start the task
            task.resume()
}
