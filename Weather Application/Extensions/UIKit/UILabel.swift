//
//  UILabel.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 05.12.2021.
//

import UIKit

extension UILabel {
    func addAuthenticationLabel(text: String) {
        self.font = UIFont.preferredFont(forTextStyle: .title1)
        self.text = text
        self.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        self.textColor = .white
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
