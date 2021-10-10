//
//  ExerciseService.swift
//  FitnessTracker
//
//  Created by Zaf on 23.9.21.
//

import Foundation;
import SQLite3;

class ExerciseService {
    
    func getExercises(token: String) -> Void {
        let accessToken = token;
        guard let url = URL(string: "http://localhost:8080/api/exercise/") else {
            return;
        }

        var request = URLRequest(url: url);
        request.httpMethod = "GET";
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization");
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                return;
            }
            
            
            guard let exercisesResponse = try? JSONDecoder().decode(Exercises.self, from: data) else {
                print("Failed retrieving data");
                return;
            }
            
            Repository.shared.insertExercises(exercises: exercisesResponse);
            RegulatorService.shared.release();
        }.resume();
    }
    
}
