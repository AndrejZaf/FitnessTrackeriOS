//
//  WorkoutService.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import Foundation

class WorkoutService {
    func getWorkouts(token: String) -> Void {
        let accessToken = token;
        guard let url = URL(string: "http://localhost:8080/api/workout/") else {
            return;
        }

        var request = URLRequest(url: url);
        request.httpMethod = "GET";
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization");
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                return;
            }
            
            
            guard let workoutsResponse = try? JSONDecoder().decode(WorkoutRequests.self, from: data) else {
                print("Failed retrieving data");
                return;
            }
            
            Repository.shared.insertWorkouts(workouts: workoutsResponse);
            RegulatorService.shared.release();
            RegulatorService.shared.setAvailableToLoad(true);
        }.resume();
    }
    
    func loadWorkouts() -> [WorkoutEntity] {
        return Repository.shared.getWorkouts();
    }
    
    func addWorkout(token: String, workoutEntity: WorkoutEntity) -> Void {
        
        var createWorkoutRequest = CreateWorkoutRequest(name: workoutEntity.name, exercises: []);
        
        // Move the data to request
        workoutEntity.exercises.forEach({
            let exerciseUid = Repository.shared.getExerciseUidByName(name: $0.name);
            var createExerciseRequest = CreateExerciseRequest(uid: exerciseUid, sets: []);
            $0.exerciseSets.forEach({
                let createSetRequest = CreateSetRequest(reps: $0.reps, weight: $0.weight, restPeriod: $0.rest_period);
                createExerciseRequest.sets.append(createSetRequest);
            })
            createWorkoutRequest.exercises.append(createExerciseRequest);
        })
        
        
        guard let url = URL(string: "http://localhost:8080/api/workout/") else {
            return;
        }
        
        var request = URLRequest(url: url);
        request.httpMethod = "POST";
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization");
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        request.httpBody = try? JSONEncoder().encode(createWorkoutRequest);
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                return;
            }
            
            // TODO: Add data to request body, and expect UID String in return
            
            
            guard let workoutResponse = try? JSONDecoder().decode(CreateWorkoutResponse.self, from: data) else {
                print("Failed retrieving data");
                return;
            }
            var workoutRequest = WorkoutRequest(name: workoutEntity.name, uid: workoutResponse.uid, exercises: []);
            
            workoutEntity.exercises.forEach({
                let exerciseUid = Repository.shared.getExerciseUidByName(name: $0.name);
                var newWorkoutExercise = WorkoutExercise(uid: exerciseUid, sets: []);
                $0.exerciseSets.forEach({
                    let newSet = Set(reps: $0.reps, weight: $0.weight, restPeriod: $0.rest_period)
                    newWorkoutExercise.sets?.append(newSet);
                })
                workoutRequest.exercises?.append(newWorkoutExercise);
            })
            
            Repository.shared.insertWorkouts(workouts: [workoutRequest]);
            WorkoutViewModel().loadInitalList();
            RegulatorService.shared.release();
        }.resume();
    }
    
    func updateWorkout(token: String, workoutEntity: WorkoutEntity) -> Void {
        var createWorkoutRequest = CreateWorkoutRequest(name: workoutEntity.name, exercises: []);
        
        // Move the data to request
        workoutEntity.exercises.forEach({
            let exerciseUid = Repository.shared.getExerciseUidByName(name: $0.name);
            var createExerciseRequest = CreateExerciseRequest(uid: exerciseUid, sets: []);
            $0.exerciseSets.forEach({
                let createSetRequest = CreateSetRequest(reps: $0.reps, weight: $0.weight, restPeriod: $0.rest_period);
                createExerciseRequest.sets.append(createSetRequest);
            })
            createWorkoutRequest.exercises.append(createExerciseRequest);
        })
        
        
        guard let url = URL(string: "http://localhost:8080/api/workout/\(workoutEntity.uid)") else {
            return;
        }
        
        var request = URLRequest(url: url);
        request.httpMethod = "PUT";
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization");
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        request.httpBody = try? JSONEncoder().encode(createWorkoutRequest);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                return;
            }
            Repository.shared.updateWorkout(workout: workoutEntity)
            RegulatorService.shared.release();
        }.resume();
    }
    
    func deleteWorkout(token: String, workoutEntity: WorkoutEntity) -> Void {
        guard let url = URL(string: "http://localhost:8080/api/workout/\(workoutEntity.uid)") else {
            return;
        }
        
        var request = URLRequest(url: url);
        request.httpMethod = "DELETE";
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization");
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                return;
            }
            
            Repository.shared.deleteWorkout(workoutUid: workoutEntity.uid);
            RegulatorService.shared.release();
        }.resume();
    }
}
