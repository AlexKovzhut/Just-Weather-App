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

    //background view
    private let backgroundView = UIImageView()
    
    //stack view
    private let searchStuckView = UIStackView()
    private let tempStuckView = UIStackView()
    
    //search field and buttons
    private let locationButton = UIButton()
    private let searchButton = UIButton()
    private let searchTextField = UITextField()
    
    //view elements
    private let dayTimeLabel = UILabel()
    private let cityCountryLabel = UILabel()
    private let conditionImageView = UIImageView()
    private let temperaturelabel = UILabel()
    private let descriptionLabel = UILabel()
    private let windPressureLabel = UILabel()
    private let humidityVisibilityLabel = UILabel()
    private let tempMaxMinlabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setStyle()
        setLayout()
        //setupNavBar()
    }
}

// MARK: - View

extension WeatherViewController {
//    private func setupNavBar() {
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.topItem?.title = "Good afternoon, \(UserSettings.userModel.name)"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(settingsButtonPresssed))
//
//        let attrs = [
//            NSAttributedString.Key.foregroundColor: UIColor.label,
//            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)
//        ]
//
//        navigationController?.navigationBar.largeTitleTextAttributes = attrs
//    }
    
    private func setup() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        searchTextField.delegate = self
        weatherService.delegate = self
    }

    private func setStyle() {
        //Background View
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleToFill
        backgroundView.backgroundColor = .white

        //StuckViews
        searchStuckView.translatesAutoresizingMaskIntoConstraints = false
        searchStuckView.spacing = 10
        searchStuckView.axis = .horizontal
        searchStuckView.alignment = .fill
        searchStuckView.distribution = .fillProportionally
        
        tempStuckView.translatesAutoresizingMaskIntoConstraints = false
        tempStuckView.spacing = 10
        tempStuckView.axis = .horizontal
        tempStuckView.alignment = .fill
        tempStuckView.distribution = .fillProportionally
        
        //Field, buttons and labels in StuckView
        //searchStuckView
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.placeholder = "Search"
        searchTextField.textAlignment = .left
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .systemFill
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        searchButton.addTarget(self, action: #selector(searchPressed(_:)), for: .primaryActionTriggered)
        
        //cityCountryStuckView and locationStuckView
        dayTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        dayTimeLabel.text = "Nov 11, 11:11am"
        dayTimeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        cityCountryLabel.translatesAutoresizingMaskIntoConstraints = false
        cityCountryLabel.text = "Default city, Deafault country"
        cityCountryLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setBackgroundImage(UIImage(systemName: "location.square"), for: .normal)
        locationButton.addTarget(self, action: #selector(locationPressed(_:)), for: .primaryActionTriggered)
        
        //mainTempStuckView
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.image = UIImage(systemName: "sun.max")
        
        temperaturelabel.translatesAutoresizingMaskIntoConstraints = false
        temperaturelabel.attributedText = makeTemperatureText(with: "11")
        
        //descriptionLabel
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Feels like 99ºC. Snow"
        
        //
        windPressureLabel.translatesAutoresizingMaskIntoConstraints = false
        windPressureLabel.text = "1.1m/s NW  Pressure: 1111hPa"
        
        humidityVisibilityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityVisibilityLabel.text = "Humidity: 11%  Visibility: 1000"
        
        tempMaxMinlabel.translatesAutoresizingMaskIntoConstraints = false
        tempMaxMinlabel.text = "Max: 11 | Min: 11"
    }

    //View of temperature text
    private func makeTemperatureText(with temperature: String) -> NSAttributedString {
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .largeTitle)

        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .largeTitle)

        let text = NSMutableAttributedString(string: temperature, attributes: boldTextAttributes)
        text.append(NSAttributedString(string: "ºC", attributes: plainTextAttributes))

        return text
    }

    private func setLayout() {
        view.addSubview(backgroundView)
        view.addSubview(searchStuckView)
        view.addSubview(locationButton)
        view.addSubview(dayTimeLabel)
        view.addSubview(cityCountryLabel)
        view.addSubview(tempStuckView)
        view.addSubview(descriptionLabel)
        view.addSubview(windPressureLabel)
        view.addSubview(humidityVisibilityLabel)
        view.addSubview(tempMaxMinlabel)
        
        searchStuckView.addArrangedSubview(searchTextField)
        searchStuckView.addArrangedSubview(searchButton)
        
        tempStuckView.addArrangedSubview(conditionImageView)
        tempStuckView.addArrangedSubview(temperaturelabel)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            searchStuckView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            searchStuckView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchStuckView.trailingAnchor, multiplier: 2),
            
            locationButton.topAnchor.constraint(equalToSystemSpacingBelow: searchStuckView.bottomAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: locationButton.trailingAnchor, multiplier: 2),
            
            dayTimeLabel.topAnchor.constraint(equalToSystemSpacingBelow: locationButton.bottomAnchor, multiplier: 0),
            dayTimeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            cityCountryLabel.topAnchor.constraint(equalTo: dayTimeLabel.bottomAnchor, constant: 1),
            cityCountryLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: cityCountryLabel.trailingAnchor, multiplier: 2),
            
            tempStuckView.topAnchor.constraint(equalToSystemSpacingBelow: cityCountryLabel.bottomAnchor, multiplier: 6),
            tempStuckView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tempStuckView.trailingAnchor, multiplier: 2),
            
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: tempStuckView.bottomAnchor, multiplier: 1),
            descriptionLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: descriptionLabel.trailingAnchor, multiplier: 2),
            
            windPressureLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 26),
            windPressureLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: windPressureLabel.trailingAnchor, multiplier: 2),

            humidityVisibilityLabel.topAnchor.constraint(equalTo: windPressureLabel.bottomAnchor, constant: 16),
            humidityVisibilityLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: humidityVisibilityLabel.trailingAnchor, multiplier: 2),

            tempMaxMinlabel.topAnchor.constraint(equalTo: humidityVisibilityLabel.bottomAnchor, constant: 16),
            tempMaxMinlabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tempMaxMinlabel.trailingAnchor, multiplier: 2),
            
            locationButton.widthAnchor.constraint(equalToConstant: 35),
            locationButton.heightAnchor.constraint(equalToConstant: 35),

            searchButton.widthAnchor.constraint(equalToConstant: 35),
            searchButton.heightAnchor.constraint(equalToConstant: 35),

            conditionImageView.heightAnchor.constraint(equalToConstant: 35),
            conditionImageView.widthAnchor.constraint(equalToConstant: 35),
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

        if let cityName = searchTextField.text {
            weatherService.fetchWeather(cityName: cityName)
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
        //self.dayTimeLabel.text = weather.dayTime
        self.cityCountryLabel.text = "\(weather.cityName), \(weather.countryName)"
        self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        self.temperaturelabel.attributedText = self.makeTemperatureText(with: weather.tempString)
        self.descriptionLabel.text = "Feels like \(weather.tempFeelsLikeString)ºC. \(weather.mainDescription)"
        self.windPressureLabel.text = "Wind: \(weather.windSpeedString)m/s \(weather.windDegreesString)  Pressure: \(weather.pressureString)hPa"
        self.humidityVisibilityLabel.text = "Humidity: \(weather.humidityString)%  Visibility: \(weather.visibilityString)km"
        self.tempMaxMinlabel.text = "Max: \(weather.tempMaxString)  Min: \(weather.tempMinString)"
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
