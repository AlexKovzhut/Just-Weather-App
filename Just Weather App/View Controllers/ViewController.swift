//
//  ViewController.swift
//  Just Weather App
//
//  Created by Alexander Kovzhut on 04.07.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var weatherImageLabel: UIImageView!
    @IBOutlet weak var citylabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperaturelabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var networkManager = NetworkManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager ()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.onCompletion = {  [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterface(weather: currentWeather)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }  else {
            print("Location services are not enabled")
        }
    }
    
    //search func
    func presentSearchAlertController(withTitle title: String?,
                                      message: String?,
                                      style: UIAlertController.Style,
                                      completionHandler: @escaping (String) -> Void
    ) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["Moscow", "Sydney", "New York", "Tokyo", "London"]
            tf.placeholder = cities.randomElement()
        }
        
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                
                completionHandler(city)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    //update interface func
    func updateInterface(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.citylabel.text = weather.cityName
            self.temperatureLabel.text = weather.tempString
            self.feelsLikeTemperaturelabel.text = weather.tempFeelsLikeString
            self.weatherImageLabel.image = UIImage(systemName: weather.systemIconNameString)
            self.descriptionLabel.text = weather.weatherDescription
        }
    }

    @IBAction func searchForCity(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) {
            [unowned self] city in self.networkManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
