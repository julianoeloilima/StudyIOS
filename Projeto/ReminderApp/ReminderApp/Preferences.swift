//
//  Preferences.swift
//  ReminderApp
//
//  Created by Aloc SP08608 on 05/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation

public class Preferences {
    
    public static func getDoublePreference(key : String) -> Double {
        let userDefaults = UserDefaults.standard
        return userDefaults.double(forKey: key)
    }
    
    public static func setDoublePreference(key : String, value : Double) {
        setPreference(key: key, value: value)
    }

    public static func getStringPreference(key : String) -> String? {
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: key)
    }
    
    public static func setStringPreference(key : String, value : String) {
        setPreference(key: key, value: value)
    }
    
    private static func setPreference(key : String, value : Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }

}
