//
//  ViewController.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 14.11.2021.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    private let locationManager = CLLocationManager()
    
    var weatherService = WeatherService()
    
    private let backgroundView = UIImageView()
    
    private let searchStuckView = UIStackView()
    private let weatherStuckView = UIStackView()
    
    private let locationButton = UIButton()
    private let searchButton = UIButton()
    private let searchTextField = UITextField()
    
    private let conditionImageView = UIImageView()
    private let temperaturelabel = UILabel()
    private let cityLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setStyle()
        setLayout()
    }
}

extension WeatherViewController {
    private func setup() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchTextField.delegate = self
        weatherService.delegate = self
    }
    
    private func setStyle() {
        // Main
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .black
        backgroundView.contentMode = .scaleToFill
        
        searchStuckView.translatesAutoresizingMaskIntoConstraints = false
        searchStuckView.spacing = 10
        searchStuckView.axis = .horizontal
        searchStuckView.alignment = .fill
        searchStuckView.distribution = .fillProportionally
        
        weatherStuckView.translatesAutoresizingMaskIntoConstraints = false
        weatherStuckView.spacing = 15
        weatherStuckView.axis = .vertical
        weatherStuckView.alignment = .fill
        weatherStuckView.distribution = .fill
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setBackgroundImage(UIImage(systemName: "location.north.circle.fill"), for: .normal)
        locationButton.tintColor = .label
        locationButton.addTarget(self, action: #selector(locationPressed(_:)), for: .primaryActionTriggered)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        searchButton.addTarget(self, action: #selector(searchPressed(_:)), for: .primaryActionTriggered)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.placeholder = "Search"
        searchTextField.textAlignment = .left
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .systemFill
        
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.image = UIImage(systemName: "cloud.rain")
        conditionImageView.tintColor = .systemYellow
        
        temperaturelabel.translatesAutoresizingMaskIntoConstraints = false
        temperaturelabel.attributedText = makeTemperatureText(with: "21")
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.text = "Los Angeles"
        cityLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
    }
    
    private func makeTemperatureText(with temperature: String) -> NSAttributedString {
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.boldSystemFont(ofSize: 100)
        
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.systemFont(ofSize: 80)
        
        let text = NSMutableAttributedString(string: temperature, attributes: boldTextAttributes)
        text.append(NSAttributedString(string: "ºC", attributes: plainTextAttributes))
        
        return text
    }
    
    private func setLayout() {
        view.addSubview(backgroundView)
        view.addSubview(searchStuckView)
        view.addSubview(weatherStuckView)
        
        searchStuckView.addArrangedSubview(locationButton)
        searchStuckView.addArrangedSubview(searchTextField)
        searchStuckView.addArrangedSubview(searchButton)
        
        weatherStuckView.addArrangedSubview(conditionImageView)
        weatherStuckView.addArrangedSubview(temperaturelabel)
        weatherStuckView.addArrangedSubview(cityLabel)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchStuckView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            searchStuckView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchStuckView.trailingAnchor, multiplier: 1),
            
            weatherStuckView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherStuckView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            
            conditionImageView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    // After pressed search button
    @objc func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherService.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    // After pressed location button
    @objc func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            weatherService.fetchWeather(latitude: latitude, longitude: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - WeatherServiceDelegate

extension WeatherViewController: WeatherServiceDelegate {
    // Update UI elements
    func didFetchWeather(_ weatherService: WeatherService, _ weather: WeatherModel) {
        self.temperaturelabel.attributedText = self.makeTemperatureText(with: weather.temperatureString)
        self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        self.cityLabel.text = weather.cityName
    }
    
    func didFailWithError(_ weatherService: WeatherService, _ error: ServiceError) {
        let message: String
        
        switch error {
        case .network(statusCode: let statusCode):
            message = "Networking error. Status code: \(statusCode)"
        case .parsing:
            message = "JSON weather data could not be parsed"
        case .general(reason: let reason):
            message = reason
        }
        showErrorAlert(with: message)
    }
        
        func showErrorAlert(with message: String) {
            let alert = UIAlertController(title: "Error fetching weather", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
}
