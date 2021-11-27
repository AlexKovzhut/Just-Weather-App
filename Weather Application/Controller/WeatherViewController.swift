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

    //Background View
    private let backgroundView = UIImageView()
    
    //StackViews
    private let searchStuckView = UIStackView()
    private let cityCountryStuckView = UIStackView()
    private let mainTempStuckView = UIStackView()
    private let descriptionTempStuckView = UIStackView()
    private let windStuckView = UIStackView()
    private let firstOtherStuckView = UIStackView()
    private let tempMinMaxStuckView = UIStackView()
    private let secondOtherStuckView = UIStackView()
    private let thirdOtherStuckView = UIStackView()
    
    //Search field and buttons
    private let locationButton = UIButton()
    private let searchButton = UIButton()
    private let searchTextField = UITextField()
    
    //Weather description elements
    private let dayTimeLabel = UILabel()
    private let cityLabel = UILabel()
    private let countryLabel = UILabel()
    private let conditionImageView = UIImageView()
    private let temperaturelabel = UILabel()
    private let mainDescription = UILabel()
    private let secondarydDescription = UILabel()
    private let tempMaxlabel = UILabel()
    private let tempMinlabel = UILabel()
    private let tempFeelsLike = UILabel()
    private let windSpeedLabel = UILabel()
    private let windDegreesLabel = UILabel()
    private let pressureLabel = UILabel()
    private let humidityLabel = UILabel()
    private let visibilityLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Good day, Alexander"
        
        setup()
        setStyle()
        setLayout()
    }
}

// MARK: - View

extension WeatherViewController {
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
        
        cityCountryStuckView.translatesAutoresizingMaskIntoConstraints = false
        cityCountryStuckView.spacing = 1
        cityCountryStuckView.axis = .horizontal
        cityCountryStuckView.alignment = .leading
        cityCountryStuckView.distribution = .fillEqually
        
        mainTempStuckView.translatesAutoresizingMaskIntoConstraints = false
        mainTempStuckView.spacing = 4
        mainTempStuckView.axis = .horizontal
        mainTempStuckView.alignment = .leading
        mainTempStuckView.distribution = .fill
        
        descriptionTempStuckView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTempStuckView.spacing = 4
        descriptionTempStuckView.axis = .horizontal
        descriptionTempStuckView.alignment = .leading
        descriptionTempStuckView.distribution = .fill
        
        windStuckView.translatesAutoresizingMaskIntoConstraints = false
        windStuckView.spacing = 4
        windStuckView.axis = .horizontal
        windStuckView.alignment = .leading
        windStuckView.distribution = .fill
        
        firstOtherStuckView.translatesAutoresizingMaskIntoConstraints = false
        firstOtherStuckView.spacing = 24
        firstOtherStuckView.axis = .horizontal
        firstOtherStuckView.alignment = .leading
        firstOtherStuckView.distribution = .fillProportionally
        
        tempMinMaxStuckView.translatesAutoresizingMaskIntoConstraints = false
        tempMinMaxStuckView.spacing = 0
        tempMinMaxStuckView.axis = .horizontal
        tempMinMaxStuckView.alignment = .fill
        tempMinMaxStuckView.distribution = .fillEqually
        
        secondOtherStuckView.translatesAutoresizingMaskIntoConstraints = false
        secondOtherStuckView.spacing = 24
        secondOtherStuckView.axis = .horizontal
        secondOtherStuckView.alignment = .leading
        secondOtherStuckView.distribution = .fill
        
        thirdOtherStuckView.translatesAutoresizingMaskIntoConstraints = false
        thirdOtherStuckView.spacing = 24
        thirdOtherStuckView.axis = .horizontal
        thirdOtherStuckView.alignment = .leading
        thirdOtherStuckView.distribution = .fill
        
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
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.text = "Default city"
        cityLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.text = "Deafault country"
        countryLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setBackgroundImage(UIImage(systemName: "location.north.circle"), for: .normal)
        locationButton.addTarget(self, action: #selector(locationPressed(_:)), for: .primaryActionTriggered)
        
        //mainTempStuckView
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.image = UIImage(systemName: "sun.max")
        
        temperaturelabel.translatesAutoresizingMaskIntoConstraints = false
        temperaturelabel.attributedText = makeTemperatureText(with: "11")
        
        //descriptionTempStuckView
        tempFeelsLike.translatesAutoresizingMaskIntoConstraints = false
        tempFeelsLike.text = "Feels like 11ºC."
        
        mainDescription.translatesAutoresizingMaskIntoConstraints = false
        mainDescription.text = "Deafault main description."
        mainDescription.font = UIFont.preferredFont(forTextStyle: .body)
        //mainDescription.textColor = .systemOrange
        
        secondarydDescription.translatesAutoresizingMaskIntoConstraints = false
        secondarydDescription.text = "Deafault secondaryd description"
        secondarydDescription.font = UIFont.preferredFont(forTextStyle: .body)
        //secondarydDescription.textColor = .systemOrange
        
        //firstOtherStuckView(windStuckView) and secondOtherStuckView
        tempMaxlabel.translatesAutoresizingMaskIntoConstraints = false
        tempMaxlabel.text = "Max: 99ºC"

        tempMinlabel.translatesAutoresizingMaskIntoConstraints = false
        tempMinlabel.text = "Min: 11ºC"

        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.text = "1.1m/s"
        
        windDegreesLabel.translatesAutoresizingMaskIntoConstraints = false
        windDegreesLabel.text = "NW"
        
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.text = "Pressure: 1111hPa"
        
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.text = "Humidity: 11%"
        
        visibilityLabel.translatesAutoresizingMaskIntoConstraints = false
        visibilityLabel.text = "Visibility: 1000"

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
        view.addSubview(cityCountryStuckView)
        view.addSubview(mainTempStuckView)
        view.addSubview(descriptionTempStuckView)
        view.addSubview(firstOtherStuckView)
        view.addSubview(secondOtherStuckView)
        view.addSubview(thirdOtherStuckView)
        
        searchStuckView.addArrangedSubview(searchTextField)
        searchStuckView.addArrangedSubview(searchButton)
        
        cityCountryStuckView.addArrangedSubview(cityLabel)
        cityCountryStuckView.addArrangedSubview(countryLabel)
        
        mainTempStuckView.addArrangedSubview(conditionImageView)
        mainTempStuckView.addArrangedSubview(temperaturelabel)
        
        descriptionTempStuckView.addArrangedSubview(tempFeelsLike)
        descriptionTempStuckView.addArrangedSubview(mainDescription)
        descriptionTempStuckView.addArrangedSubview(secondarydDescription)
        
        windStuckView.addArrangedSubview(windSpeedLabel)
        windStuckView.addArrangedSubview(windDegreesLabel)
        
        tempMinMaxStuckView.addArrangedSubview(tempMaxlabel)
        tempMinMaxStuckView.addArrangedSubview(tempMinlabel)
        
        firstOtherStuckView.addArrangedSubview(windStuckView)
        firstOtherStuckView.addArrangedSubview(tempMinMaxStuckView)
        
        secondOtherStuckView.addArrangedSubview(humidityLabel)
        secondOtherStuckView.addArrangedSubview(pressureLabel)
        
        thirdOtherStuckView.addArrangedSubview(visibilityLabel)
        
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
            
            dayTimeLabel.topAnchor.constraint(equalToSystemSpacingBelow: locationButton.bottomAnchor, multiplier: 2),
            dayTimeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            cityCountryStuckView.topAnchor.constraint(equalTo: dayTimeLabel.bottomAnchor, constant: 1),
            cityCountryStuckView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: cityCountryStuckView.trailingAnchor, multiplier: 2),
            
            mainTempStuckView.topAnchor.constraint(equalToSystemSpacingBelow: cityCountryStuckView.bottomAnchor, multiplier: 6),
            mainTempStuckView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainTempStuckView.trailingAnchor, multiplier: 2),
            
            descriptionTempStuckView.topAnchor.constraint(equalToSystemSpacingBelow: mainTempStuckView.bottomAnchor, multiplier: 1),
            descriptionTempStuckView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: descriptionTempStuckView.trailingAnchor, multiplier: 2),
            
            firstOtherStuckView.topAnchor.constraint(equalTo: descriptionTempStuckView.bottomAnchor, constant: 26),
            firstOtherStuckView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: firstOtherStuckView.trailingAnchor, multiplier: 2),
            
            secondOtherStuckView.topAnchor.constraint(equalTo: firstOtherStuckView.bottomAnchor, constant: 16),
            secondOtherStuckView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: secondOtherStuckView.trailingAnchor, multiplier: 2),
            
            thirdOtherStuckView.topAnchor.constraint(equalTo: secondOtherStuckView.bottomAnchor, constant: 16),
            thirdOtherStuckView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: thirdOtherStuckView.trailingAnchor, multiplier: 2),
            
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
        self.dayTimeLabel.text = weather.dayTime
        self.cityLabel.text = weather.cityName
        self.countryLabel.text = weather.countryName
        self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        self.temperaturelabel.attributedText = self.makeTemperatureText(with: weather.tempString)
        self.tempFeelsLike.text = weather.tempFeelsLikeString
        self.mainDescription.text = weather.mainDescription
        self.secondarydDescription.text = weather.secondarydDescription
        self.windSpeedLabel.text = weather.windSpeed
        self.windDegreesLabel.text = weather.windDegrees
        self.humidityLabel.text = weather.humidity
        self.visibilityLabel.text = weather.visibility
        self.tempMaxlabel.text = weather.tempMaxString
        self.tempMinlabel.text = weather.tempMinString
        self.pressureLabel.text = weather.pressure
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
