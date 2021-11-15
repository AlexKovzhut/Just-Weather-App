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
    private let rootStuckView = UIStackView()
    private let searchStuckView = UIStackView()
    
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
        searchTextField.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherService.delegate = self
    }
    
    private func setStyle() {
        
        // Main
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.image = UIImage(named: "Sunny-Cloudy")
        backgroundView.contentMode = .scaleToFill
        
        rootStuckView.translatesAutoresizingMaskIntoConstraints = false
        rootStuckView.spacing = 8
        rootStuckView.axis = .vertical
        rootStuckView.alignment = .trailing
        rootStuckView.distribution = .fill
        
        searchStuckView.translatesAutoresizingMaskIntoConstraints = false
        searchStuckView.spacing = 8
        searchStuckView.axis = .horizontal
        searchStuckView.alignment = .fill
        searchStuckView.distribution = .fill
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setBackgroundImage(UIImage(systemName: "location.circle"), for: .normal)
        locationButton.tintColor = .label
        locationButton.addTarget(self, action: #selector(locationPressed(_:)), for: .primaryActionTriggered)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass.circle"), for: .normal)
        searchButton.tintColor = .label
        searchButton.addTarget(self, action: #selector(searchPressed(_:)), for: .primaryActionTriggered)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.placeholder = "Search"
        searchTextField.textAlignment = .left
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .systemFill
        
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.image = UIImage(systemName: "cloud.sun.fill")
        conditionImageView.tintColor = .label
        
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
        view.addSubview(rootStuckView)
        view.addSubview(searchStuckView)
        
        rootStuckView.addArrangedSubview(searchStuckView)
        rootStuckView.addArrangedSubview(conditionImageView)
        rootStuckView.addArrangedSubview(temperaturelabel)
        rootStuckView.addArrangedSubview(cityLabel)
        
        searchStuckView.addArrangedSubview(locationButton)
        searchStuckView.addArrangedSubview(searchTextField)
        searchStuckView.addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rootStuckView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStuckView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: rootStuckView.trailingAnchor, multiplier: 1),
            
            searchStuckView.widthAnchor.constraint(equalTo: rootStuckView.widthAnchor),
            
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            
            conditionImageView.heightAnchor.constraint(equalToConstant: 120),
            conditionImageView.widthAnchor.constraint(equalToConstant: 120),
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
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - WeatherServiceDelegate

extension WeatherViewController: WeatherServiceDelegate {
    
    // Update UI elements
    func didFetchWeather(_ weatherService: WeatherService, weather: Weather) {
        temperaturelabel.attributedText = makeTemperatureText(with: weather.temperatureString)
        cityLabel.text = weather.cityName
        
    }
}
