//
//  JwtService.swift
//  FitnessTracker
//
//  Created by Zaf on 10.10.21.
//

import Foundation;
import SwiftJWT;

struct JwtService {
    
    func decodeJwt(token: String) -> Void {
        let defaults = UserDefaults.standard;
        let myJwt = try? JWT<JwtClaims>(jwtString: token);
        defaults.setValue(Int(myJwt!.claims.exp) * 1000, forKey: "exp");
    }
    
    func checkTokenValidity() -> Void {
        let defaults = UserDefaults.standard;
        let tokenMilliseconds = defaults.value(forKey: "exp");
        let dateNow = Date().addingTimeInterval(10800)
        let expiryDate = Date(milliseconds: tokenMilliseconds as! Int);
        if dateNow > expiryDate {
            AuthService().refreshToken();
        }
    }
}
