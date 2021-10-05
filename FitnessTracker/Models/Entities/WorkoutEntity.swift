//
//  WorkoutEntity.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import Foundation

struct WorkoutEntity: Identifiable, Codable {
    var id: Int;
    var uid: String;
    var name: String;
    var exercises: [WorkoutExerciseEntity];
}
