//
//  UIStackView.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 05.12.2021.
//

import UIKit

extension UIStackView {
    func addAuthenticationStackView(axis: NSLayoutConstraint.Axis) {
        self.axis = axis
        self.spacing = 16
        self.alignment = .fill
        self.distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
