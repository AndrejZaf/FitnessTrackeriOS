//
//  WorkoutExerciseEntity.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import Foundation

struct WorkoutExerciseEntity: Identifiable, Codable {
    var id: Int;
    var name: String;
    var exercise_id: Int;
    var workout_id: Int;
    var exerciseSets: [SetEntity];
}
