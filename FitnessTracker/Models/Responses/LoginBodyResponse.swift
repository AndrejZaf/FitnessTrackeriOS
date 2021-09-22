//
//  LoginBodyResponse.swift
//  FitnessTracker
//
//  Created by Zaf on 20.9.21.
//

import Foundation

struct LoginBodyResponse: Codable {
    let accessToken: String?;
    let refreshToken: String?;
    let message: String?;
    let success: Bool?;
}
