//
//  WorkoutsRequest.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import Foundation

struct WorkoutRequest: Codable {
    let name: String?;
    let uid: String?;
    let exercises: [WorkoutExercise]?;
}
 
// MARK: - Exercise
struct WorkoutExercise: Codable {
    let uid: String?;
    let sets: [Set]?;
}
 
// MARK: - Set
struct Set: Codable {
    let reps, weight, restPeriod: Int?;
}
 
typealias WorkoutRequests = [WorkoutRequest];
