//
//  UserService.swift
//  FitnessTracker
//
//  Created by Zaf on 10.10.21.
//

import SwiftUI

class UserService {
    func changeMeasurementSystem(system: String, token: String) -> Void {
        let accessToken = token;
        guard let url = URL(string: "http://localhost:8080/api/user/measurement") else {
            return;
        }

        var body = UpdateMeasurementSystemRequest(measurementSystem: returnRequestString(system: system));
        
        var request = URLRequest(url: url);
        request.httpMethod = "POST";
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization");
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        request.httpBody = try? JSONEncoder().encode(body);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                return;
            }
            
            AlertToast(displayMode: .hud, type: .regular, title: "Measurement System Changed")
        }.resume();
    }
    
    func returnRequestString(system: String) -> String {
        switch system {
        case "Imperial":
            return "IMPERIAL_SYSTEM";
        case "Metric":
            return "METRIC_SYSTEM";
        default:
            return "";
        }
    }
}
