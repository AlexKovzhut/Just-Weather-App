//
//  AuthViewController.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 23.11.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    //background View
    private let scrollView = UIScrollView()
    private let backgroundView = UIView()
    
    //stack view
    private var authStackView = UIStackView()
    
    //view elements
    private let logoLabel = UILabel()
    private let firstNameTextField = UITextField()
    private let lastNameTextField = UITextField()
    private let phoneNumberTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
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

extension SignUpViewController {
    private func setup() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setStyle() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleToFill
        backgroundView.backgroundColor = UIColor(red: 80, green: 0, blue: 190, alpha: 1)
        
        authStackView.addAuthenticationStackView(axis: .vertical)
        
        logoLabel.addAuthenticationLabel(text: "Registration")
        
        firstNameTextField.addAuthenticationTextField(placeholderText: "First name")
        lastNameTextField.addAuthenticationTextField(placeholderText: "Last name")
        phoneNumberTextField.addAuthenticationTextField(placeholderText: "Phone number")
        emailTextField.addAuthenticationTextField(placeholderText: "Email address")
        passwordTextField.addAuthenticationTextField(placeholderText: "Password")
        
        signUpButton.addAuthenticationButton(title: "Sign Up", selector: #selector(signUpButtonTapped))
    }
    
    private func setLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(logoLabel)
        backgroundView.addSubview(authStackView)
        
        authStackView.addArrangedSubview(firstNameTextField)
        authStackView.addArrangedSubview(lastNameTextField)
        authStackView.addArrangedSubview(phoneNumberTextField)
        authStackView.addArrangedSubview(emailTextField)
        authStackView.addArrangedSubview(passwordTextField)
        authStackView.addArrangedSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            logoLabel.topAnchor.constraint(equalToSystemSpacingBelow: backgroundView.safeAreaLayoutGuide.topAnchor, multiplier: 15),
            logoLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundView.leadingAnchor, multiplier: 8),
            
            authStackView.topAnchor.constraint(equalToSystemSpacingBelow: logoLabel.bottomAnchor, multiplier: 10),
            authStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundView.leadingAnchor, multiplier: 5),
            backgroundView.trailingAnchor.constraint(equalToSystemSpacingAfter: authStackView.trailingAnchor, multiplier: 5),
        ])
    }
}

// MARK: - Navigation

extension SignUpViewController {
    @objc func signUpButtonTapped() {
        
    }
}

// MARK: - textField Delegate

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
}

// MARK: - Keyboard

extension SignUpViewController {
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
