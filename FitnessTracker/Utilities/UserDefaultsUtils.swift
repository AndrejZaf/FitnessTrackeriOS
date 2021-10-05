//
//  UserDefaultsUtils.swift
//  FitnessTracker
//
//  Created by Zaf on 25.9.21.
//

import Foundation

extension UserDefaults {
    static func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil;
    }
}
