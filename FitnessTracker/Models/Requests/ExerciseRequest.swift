//
//  ExerciseRequest.swift
//  FitnessTracker
//
//  Created by Zaf on 23.9.21.
//

import Foundation

struct ExerciseDataResult: Codable {
    let exerciseApiResponse: ExerciseAPIResponse?;
}

struct ExerciseAPIResponse: Codable {
    let exercises: [ExerciseResponse];
}


struct ExerciseResponse: Codable {
    let createdAt: String?;
    let uid: String?;
    let name: String?;
    let forceType: String?;
    let level: String?;
    let mechanic: String?;
    let equipment: String?;
    let primaryMuscles: String?;
    let description: String?;
    let category: String?;
}


import Foundation

struct Exercise: Codable {
    let createdAt, uid, name, forceType: String?;
    let level: String?;
    let mechanic: String?;
    let equipment, primaryMuscles, exerciseDescription, category: String?;

    enum CodingKeys: String, CodingKey {
        case createdAt, uid, name, forceType, level, mechanic, equipment, primaryMuscles
        case exerciseDescription = "description"
        case category
    }
}

typealias Exercises = [Exercise]
