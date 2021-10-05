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
    
    func login() -> Void {
        let defaults = UserDefaults.standard;
        AuthService().login(email: email, password: password) { result in
            switch result {
                case .success(let tokens):
                    defaults.setValue(["accessToken": tokens["accessToken"]!!, "refreshToken": tokens["refreshToken"]!!], forKey: "tokens");
                    defaults.setValue(true, forKey: "loggedIn")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true;
                    }
                    ExerciseService().getExercises(token: tokens["accessToken"]!!);
                    WorkoutService().getWorkouts(token: tokens["accessToken"]!!);
                case .failure(let error):
                    print(error);
            }
        }
    }
}
