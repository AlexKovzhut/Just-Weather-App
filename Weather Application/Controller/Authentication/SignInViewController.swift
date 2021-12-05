//
//  SignInViewController.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 05.12.2021.
//

import UIKit

class SignInViewController: UIViewController {
    //background View
    private let scrollView = UIScrollView()
    private let backgroundView = UIView()
    
    //stack view
    private let textFieldStackView = UIStackView()
    private let buttonsStackViews = UIStackView()
    
    //view elements
    private let logoImage = UIImageView()
    private let logoLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextFied = UITextField()
    private let signInButton = UIButton()
    private let signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setStyle()
        setLayout()
        registerKeyboardNotification()
    }
    
    deinit {
        removeKeyboardNotification()
    }
}

// MARK: - View

extension SignInViewController {
    private func setup() {
        emailTextField.delegate = self
        passwordTextFied.delegate = self
    }
    
    private func setStyle() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleToFill
        backgroundView.backgroundColor = UIColor(red: 80, green: 0, blue: 190, alpha: 1)
        
        textFieldStackView.addAuthenticationStackView(axis: .vertical)
        
        buttonsStackViews.addAuthenticationStackView(axis: .horizontal)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named: "mainLogo")
        
        logoLabel.addAuthenticationLabel(text: "Weather Application", font: UIFont(name: "Futura", size: 27)!)
        
        emailTextField.addAuthenticationTextField(placeholderText: "Email address")
        
        passwordTextFied.addAuthenticationTextField(placeholderText: "Password")
        
        signInButton.addAuthenticationButton(title: "Sign In")
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
        signUpButton.addAuthenticationButton(title: "Sign Up")
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(logoImage)
        backgroundView.addSubview(logoLabel)
        backgroundView.addSubview(textFieldStackView)
        backgroundView.addSubview(buttonsStackViews)
        
        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextFied)
        
        buttonsStackViews.addArrangedSubview(signInButton)
        buttonsStackViews.addArrangedSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            logoImage.topAnchor.constraint(equalToSystemSpacingBelow: backgroundView.safeAreaLayoutGuide.topAnchor, multiplier: 5),
            logoImage.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 280),
            logoImage.widthAnchor.constraint(equalToConstant: 330),
            
            logoLabel.topAnchor.constraint(equalToSystemSpacingBelow: logoImage.bottomAnchor, multiplier: 5),
            logoLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundView.leadingAnchor, multiplier: 2),
            backgroundView.trailingAnchor.constraint(equalToSystemSpacingAfter: logoLabel.trailingAnchor, multiplier: 2),
            
            textFieldStackView.topAnchor.constraint(equalToSystemSpacingBelow: logoLabel.bottomAnchor, multiplier: 3),
            textFieldStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundView.leadingAnchor, multiplier: 5),
            backgroundView.trailingAnchor.constraint(equalToSystemSpacingAfter: textFieldStackView.trailingAnchor, multiplier: 5),
            
            buttonsStackViews.topAnchor.constraint(equalToSystemSpacingBelow: textFieldStackView.bottomAnchor, multiplier: 2),
            buttonsStackViews.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundView.leadingAnchor, multiplier: 5),
            backgroundView.trailingAnchor.constraint(equalToSystemSpacingAfter: buttonsStackViews.trailingAnchor, multiplier: 5),
        ])
    }
}

// MARK: - Navigation

extension SignInViewController {
    @objc func signInButtonPressed() {
        let weatherVC = WeatherViewController()
        weatherVC.modalPresentationStyle = .fullScreen
        weatherVC.modalTransitionStyle = .flipHorizontal
        self.present(weatherVC, animated: true, completion: nil)
    }
    
    @objc func signUpButtonPressed() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .popover
        signUpVC.modalTransitionStyle = .coverVertical
        self.present(signUpVC, animated: true, completion: nil)
    }
}

// MARK: - textField Delegate

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextFied.resignFirstResponder()
        
        return true
    }
}

// MARK: - Keyboard

extension SignInViewController {
    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardHeight = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight.height / 2)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
}
