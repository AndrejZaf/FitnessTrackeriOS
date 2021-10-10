//
//  JwtClaims.swift
//  FitnessTracker
//
//  Created by Zaf on 10.10.21.
//

import Foundation;
import SwiftJWT;

struct JwtClaims: Claims {
    let sub: String;
    let roles: [String];
    let iss: String;
    let exp: Int64;
}
