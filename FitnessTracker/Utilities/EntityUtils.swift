//
//  EntityUtils.swift
//  FitnessTracker
//
//  Created by Zaf on 26.9.21.
//

struct EntityUtils {
    static let exercise = ExerciseEntity(id: 1, uid: "7f075c3d-38ed-40de-be84-3738037adb3d", category: "Strength", description: "Sit down on an incline bench with a dumbbell in each hand being held at arms length. Tip: Keep the elbows close to the torso.This will be your starting position. While holding the upper arm stationary, curl the right weight forward while contracting the b", equipment: "Dumbbell", forceType: "Pull", level: "Beginner", mechanic: "Isolation", name: "Alternate Incline Dumbbell Curl", primaryMuscle: "Biceps");
    
    static let workoutExercise1 = WorkoutExerciseEntity(id: 1, name: "Flexor Incline Dumbbell Curls", exercise_id: 274, workout_id: 1, exerciseSets: [SetEntity(id: 1, reps: 10, weight: 15, rest_period: 120, workout_exercise_id: 1), SetEntity(id: 2, reps: 8, weight: 12, rest_period: 120, workout_exercise_id: 1), SetEntity(id: 3, reps: 6, weight: 10, rest_period: 120, workout_exercise_id: 1)]);
    
    static let workoutExercise2 = WorkoutExerciseEntity(id: 2, name: "Bench Dips", exercise_id: 71, workout_id: 1, exerciseSets: [SetEntity(id: 4, reps: 10, weight: 15, rest_period: 120, workout_exercise_id: 2), SetEntity(id: 5, reps: 8, weight: 12, rest_period: 120, workout_exercise_id: 2)]);
    
    static let workoutExercise3 = WorkoutExerciseEntity(id: 1, name: "Flat Bench Cable Flyes", exercise_id: 271, workout_id: 1, exerciseSets: [SetEntity(id: 6, reps: 10, weight: 15, rest_period: 120, workout_exercise_id: 3)]);
    
    static let workout = WorkoutEntity(id: 1, uid: "7f075c3d-38ed-40de-be84-3738037adb3d", name: "TestingWorkout", exercises: [workoutExercise1, workoutExercise2, workoutExercise3]);
}
