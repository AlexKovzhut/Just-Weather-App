//
//  UITextField.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 24.11.2021.
//

import UIKit

extension UITextField {
    func addField (placeholderText: String, placeholderColor: UIColor, font: UIFont, textColor: UIColor, color: CGColor, width: Double, radius: Double) {
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,attributes: [
            NSAttributedString.Key.foregroundColor: placeholderColor
        ])
        
        self.layer.borderColor = color
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
        self.font = font
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
    }
}
