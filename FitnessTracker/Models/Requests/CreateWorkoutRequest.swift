//
//  CreateWorkoutRequest.swift
//  FitnessTracker
//
//  Created by Zaf on 5.10.21.
//

import Foundation

struct CreateWorkoutRequest: Codable {
    var name: String;
    var exercises: [CreateExerciseRequest];
}

struct CreateExerciseRequest: Codable {
    var uid: String;
    var sets: [CreateSetRequest];
}

struct CreateSetRequest: Codable {
    var reps, weight, restPeriod: Int;
}
