//
//  EntityUtils.swift
//  FitnessTracker
//
//  Created by Zaf on 26.9.21.
//

struct EntityUtils {
    static let exercise = ExerciseEntity(id: 1, uid: "7f075c3d-38ed-40de-be84-3738037adb3d", category: "Strength", description: "Sit down on an incline bench with a dumbbell in each hand being held at arms length. Tip: Keep the elbows close to the torso.This will be your starting position. While holding the upper arm stationary, curl the right weight forward while contracting the b", equipment: "Dumbbell", forceType: "Pull", level: "Beginner", mechanic: "Isolation", name: "Alternate Incline Dumbbell Curl", primaryMuscle: "Biceps");
    
    static let workout = WorkoutEntity(id: 1, uid: "7f075c3d-38ed-40de-be84-3738037adb3d", name: "TestingWorkout", exercises: []);
}
