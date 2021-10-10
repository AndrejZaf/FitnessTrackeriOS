//
//  LoginViewModel.swift
//  FitnessTracker
//
//  Created by Zaf on 20.9.21.
//

import Foundation

class LoginViewModel: ObservableObject {
    var email: String = "";
    var password: String = "";
    @Published var isAuthenticated: Bool = false;
    let queue = DispatchQueue(label: "queue", attributes: .concurrent);
    func login() -> Void {
        let defaults = UserDefaults.standard;
        defaults.setValue(true, forKey: "loginAnimation");
        AuthService().login(email: email, password: password) { result in
            switch result {
                case .success(let tokens):
                    defaults.setValue(["accessToken": tokens["accessToken"]!!, "refreshToken": tokens["refreshToken"]!!], forKey: "tokens");
                    JwtService().decodeJwt(token: tokens["accessToken"]!!);
                    JwtService().checkTokenValidity();
                    DispatchQueue.main.async {
                        self.isAuthenticated = true;
                    }
                    
                    self.queue.async {
                        RegulatorService.shared.acquire();
                        ExerciseService().getExercises(token: tokens["accessToken"]!!);
                        
                        RegulatorService.shared.acquire();
                        WorkoutService().getWorkouts(token: tokens["accessToken"]!!);
                        
                        RegulatorService.shared.acquire();
                        defaults.setValue(true, forKey: "loggedIn");
                        defaults.setValue(false, forKey: "loginAnimation");
                        RegulatorService.shared.release();
                    }
                case .failure(let error):
                    defaults.setValue(false, forKey: "loginAnimation");
                    print(error);
            }
        }
    }
}
