//
//  WorkoutsRequest.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import Foundation

struct WorkoutRequest: Codable {
    var name: String?;
    var uid: String?;
    var exercises: [WorkoutExercise]?;
}
 
// MARK: - Exercise
struct WorkoutExercise: Codable {
    var uid: String?;
    var sets: [Set]?;
}
 
// MARK: - Set
struct Set: Codable {
    var reps, weight, restPeriod: Int?;
}
 
typealias WorkoutRequests = [WorkoutRequest];
