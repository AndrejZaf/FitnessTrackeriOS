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
    var measurementSystem: String = "Imperial";
    @Published var registeredEmail: String = "";
    @Published var isFinished: Bool = false;
    @Published var incorrectForm: Bool = false;
    @Published var isLoading: Bool = false;
    
    func signUp() -> Void {
        self.isLoading = true;
        AuthService().signUp(email: email, password: password, matchingPassword: matchingPassword, measurementSystem: findMeasurementSystem()) { result in
            switch result {
                case .success(let email):
                    DispatchQueue.main.async {
                        self.registeredEmail = email;
                        self.isFinished = true;
                        self.isLoading = false;
                    }
                case .failure(let error):
                    self.incorrectForm = true;
                    self.isLoading = false;
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
