//
//  UIButton.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 05.12.2021.
//

import UIKit

extension UIButton {
    func addAuthenticationButton(title: String, selector: Selector) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(name: "Futura", size: 22)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor(red: 150, green: 190, blue: 100, alpha: 1)
        self.layer.cornerRadius = 5
        self.addTarget(self, action: selector, for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
