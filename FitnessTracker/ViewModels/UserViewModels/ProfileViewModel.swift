//
//  ProfileViewModel.swift
//  FitnessTracker
//
//  Created by Zaf on 10.10.21.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var selection: String = "Imperial";
    @Published var showLoading: Bool = false;
    private let queue = DispatchQueue(label: "profileQueue", attributes: .concurrent);
    
    init() {}
    
    func sync() -> Void {
        let defaults = UserDefaults.standard;
        let tokens = defaults.dictionary(forKey: "tokens");
        let accessToken = tokens!["accessToken"];
        self.showLoading = true;
        Repository.shared.deleteWorkouts();
        self.queue.async {
            RegulatorService.shared.acquire();
            JwtService().checkTokenValidity();
            RegulatorService.shared.acquire();
            WorkoutService().getWorkouts(token: accessToken as! String);
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.showLoading = false;
        })
    }
    
    func logout() -> Void {
        let defaults = UserDefaults.standard;
        defaults.removeObject(forKey: "tokens");
        defaults.removeObject(forKey: "loggedIn");
        Repository.shared.deleteWorkouts();
        RegulatorService.shared.setAvailableToLoad(false);
    }
    
    func changeMeasurementSystem(system: String) -> Void {
        let defaults = UserDefaults.standard;
        let tokens = defaults.dictionary(forKey: "tokens");
        let accessToken = tokens!["accessToken"];
        UserService().changeMeasurementSystem(system: system, token: accessToken as! String);
    }
}
