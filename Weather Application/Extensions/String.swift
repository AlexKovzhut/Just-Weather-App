//
//  String.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 05.12.2021.
//

import UIKit

extension String {
    enum ValidType {
        case name
        case email
        case password
    }
    
    enum Regex: String {
        case name = "[a-zA-Z{1,}]"
        case email = "[a-zA-Z0-9]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,}"
        case password = "([?=.*[A-Z)(?=.*[a-z])(?=.*[0-9]).{6,)"
    }
    
    func isValid(validType: ValidType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .name:
            regex = Regex.name.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
