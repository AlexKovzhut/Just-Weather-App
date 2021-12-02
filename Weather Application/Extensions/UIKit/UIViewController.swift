//
//  UIViewController.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 02.12.2021.
//

import UIKit

extension UIViewController {
    func createCustomButton(image: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: image), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        
        return menuBarItem
    }
}
