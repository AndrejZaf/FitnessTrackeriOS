//
//  ProfileViewModel.swift
//  FitnessTracker
//
//  Created by Zaf on 10.10.21.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var selection: String = "Imperial";
    init() {
        
    }
    
    func sync() -> Void {
        let defaults = UserDefaults.standard;
        let tokens = defaults.dictionary(forKey: "tokens");
        let accessToken = tokens!["accessToken"];
        Repository.shared.deleteWorkouts();
        WorkoutService().getWorkouts(token: accessToken as! String);
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
