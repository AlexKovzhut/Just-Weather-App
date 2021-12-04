//
//  UserSettings.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 04.12.2021.
//

import Foundation

final class UserSettings {
    
    //private key
    private enum SettingsKeys: String {
        case userModel
    }
    
    static var userModel: UserModel! {
        get {
            guard let savedData = UserDefaults.standard.object(
                forKey: SettingsKeys.userModel.rawValue
            ) as? Data,
                  let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(
                    savedData
                  ) as? UserModel else { return nil }
            
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userModel.rawValue
            
            if let userModel = newValue {
                if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false) {
                    defaults.set(saveData, forKey: key)
                }
            }
        }
    }
}
