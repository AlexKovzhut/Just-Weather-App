//
//  AuthViewController.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 23.11.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    private let backgroundView = UIImageView()
    private let loginLabel = UILabel()
    private let loginTextField = UITextField()
    private let signUpButton = UIButton()
    private let authStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setStyle()
        setLayout()
    }
}

// MARK: - View

extension AuthViewController {
    private func setup() {
        loginTextField.delegate = self
    }
    
    private func setStyle() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleToFill
        backgroundView.backgroundColor = .white
        
        authStackView.translatesAutoresizingMaskIntoConstraints = false
        authStackView.spacing = 15
        authStackView.axis = .vertical
        authStackView.alignment = .fill
        authStackView.distribution = .fillEqually
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        loginLabel.text = "Weather Application"
        loginLabel.textColor = .black
        loginLabel.textAlignment = .center
        
        loginTextField.addField(
            placeholderText: "Your name",
            placeholderColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3),
            font: UIFont.systemFont(ofSize: 20),
            textColor: .black,
            color: CGColor(red: 0, green: 0, blue: 0, alpha: 1),
            width: 1,
            radius: 5)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign In", for: .normal)
        signUpButton.backgroundColor = .black
        signUpButton.tintColor = .white
        signUpButton.layer.cornerRadius = 5
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubview(backgroundView)
        view.addSubview(authStackView)
        view.addSubview(loginLabel)
        
        authStackView.addArrangedSubview(loginTextField)
        authStackView.addArrangedSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loginLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: authStackView.topAnchor, constant: -50),
            
            authStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            authStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 50),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - Navigation

extension AuthViewController {
    @objc func signUpButtonTapped() {
        if loginTextField.text != "" {
            let nameTrimmingText = loginTextField.text!.trimmingCharacters(in: .whitespaces)//delete all void spaces
            let userObject = UserModel(name: nameTrimmingText)
            
            UserSettings.userModel = userObject
            print(UserSettings.userModel ?? "")
            
            let weatherVC = WeatherViewController()
            weatherVC.modalPresentationStyle = .fullScreen
            self.present(weatherVC, animated: true, completion: nil)
            
            
        } else {
            loginTextField.placeholder = "Please, enter your name"
        }
    }
}

// MARK: - UITextFieldDelegate

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.endEditing(true)
        return true
    }
}
