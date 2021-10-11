//
//  QueryConstants.swift
//  FitnessTracker
//
//  Created by Zaf on 23.9.21.
//

import Foundation


struct QueryConstants {
    
    static let exerciseTable = """
            CREATE TABLE IF NOT EXISTS exercise (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              uid TEXT,
              category TEXT,
              description TEXT,
              equipment TEXT,
              force_type TEXT,
              level TEXT,
              mechanic TEXT,
              name TEXT,
              primary_muscles TEXT
            );
        """;
    
    static let workoutTable = """
           CREATE TABLE IF NOT EXISTS workout (
             id INTEGER PRIMARY KEY AUTOINCREMENT,
             uid TEXT UNIQUE,
             name TEXT
           );
        """;
    
    static let workoutExerciseTable = """
            CREATE TABLE IF NOT EXISTS workout_exercise (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                exercise_id INTEGER,
                workout_id INTEGER,
                FOREIGN KEY (exercise_id) REFERENCES exercise(id),
                FOREIGN KEY (workout_id) REFERENCES workout(id)
            );
        """;
    
    static let exerciseSetTable = """
            CREATE TABLE IF NOT EXISTS exercise_set (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                reps INTEGER,
                rest_period INTEGER,
                weight REAL,
                workout_exercise_id INTEGER,
                FOREIGN KEY (workout_exercise_id) REFERENCES workout_exercise(id)
            );
        """;
}
