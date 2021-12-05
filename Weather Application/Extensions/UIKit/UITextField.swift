//
//  UITextField.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 05.12.2021.
//
import UIKit

extension UITextField {
    func addAuthenticationTextField(placeholderText: String) {
        self.placeholder = placeholderText
        self.backgroundColor = .white
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.font = UIFont(name: "Futura", size: 22)
        self.tintColor = UIColor(red: 150, green: 190, blue: 100, alpha: 1)
        self.leftViewMode = .always
        self.layer.cornerRadius = 5
        self.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 1
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
