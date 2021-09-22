//
//  UserSignupRequest.swift
//  FitnessTracker
//
//  Created by Zaf on 21.9.21.
//

import Foundation

struct UserSignupRequest: Codable {
    let email: String;
    let password: String;
    let measurementSystem: String;
}
