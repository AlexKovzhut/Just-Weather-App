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
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldStackView.addAuthenticationStackView(axis: .vertical)
        
        buttonsStackViews.addAuthenticationStackView(axis: .horizontal)
        
        emailTextField.addAuthenticationTextField(placeholderText: "Email address")
        
        passwordTextFied.addAuthenticationTextField(placeholderText: "Password")
        
        signInButton.addAuthenticationButton(title: "Sign In", selector: #selector(signInButtonPressed))
        
        signUpButton.addAuthenticationButton(title: "Sign Up", selector: #selector(signUpButtonPressed))
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
            
            
        ])
    }
}

// MARK: - Navigation

extension SignInViewController {
    @objc func signInButtonPressed() {
        
    }
    
    @objc func signUpButtonPressed() {
        
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
