//
//  UserModel.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 01.12.2021.
//

import Foundation

class UserModel: NSObject, NSCoding {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    //encode our data from desired format
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
    }
    
    //decode to the desired format
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
    }
}
