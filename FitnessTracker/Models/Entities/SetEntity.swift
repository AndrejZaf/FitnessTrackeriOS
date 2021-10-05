//
//  SetEntity.swift
//  FitnessTracker
//
//  Created by Zaf on 30.9.21.
//

import Foundation

struct SetEntity: Identifiable, Codable {
    var id: Int;
    var reps: Int;
    var weight: Int;
    var rest_period: Int;
    var workout_exercise_id: Int;
}
