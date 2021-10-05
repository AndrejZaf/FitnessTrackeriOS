//
//  ExerciseEntity.swift
//  FitnessTracker
//
//  Created by Zaf on 23.9.21.
//

import Foundation

struct ExerciseEntity: Identifiable {
    let id: Int;
    let uid: String;
    let category: String;
    let description: String;
    let equipment: String;
    let forceType: String;
    let level: String;
    let mechanic: String;
    let name: String;
    let primaryMuscle: String;
}
