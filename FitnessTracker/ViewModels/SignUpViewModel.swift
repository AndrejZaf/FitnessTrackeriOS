//
//  SignUpViewModel.swift
//  FitnessTracker
//
//  Created by Zaf on 21.9.21.
//

import Foundation

class SignUpViewModel: ObservableObject {
    var email: String = "";
    var password: String = "";
    var matchingPassword: String = "";
    var measurementSystem: String = "";
    @Published var registeredEmail: String = "";
    @Published var isFinished: Bool = false;
    
    func signUp() -> Void {
        AuthService().signUp(email: email, password: password, matchingPassword: matchingPassword, measurementSystem: findMeasurementSystem()) { result in
            switch result {
                case .success(let email):
                    DispatchQueue.main.async {
                        self.registeredEmail = email;
                        self.isFinished = true;
                    }
                case .failure(let error):
                    print(error);
            }
        }
    }
    
    func findMeasurementSystem() -> String {
        if measurementSystem == "Imperial" {
            return "IMPERIAL_SYSTEM";
        }
        else {
            return "METRIC_SYSTEM;"
        }
    }
}
