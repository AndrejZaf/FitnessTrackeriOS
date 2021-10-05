//
//  DatabaseService.swift
//  FitnessTracker
//
//  Created by Zaf on 22.9.21.
//

import Foundation;
import SQLite3;

class Repository {
    var db : OpaquePointer?;
    var path : String = "\(AppStrings.appName).sqlite";
    
    static let shared = Repository();
    
    private init() {
        self.db = createDB();
        self.createTable();
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path);
        
        var db : OpaquePointer? = nil;
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is error in creating DB")
            return nil;
        }else {
            print("Database has been created with path \(path)")
            return db;
        }
    }
    
    func createTable() -> Void  {
        let queries = [QueryConstants.exerciseTable, QueryConstants.workoutTable, QueryConstants.workoutExerciseTable, QueryConstants.exerciseSetTable];
        var statement : OpaquePointer? = nil
        
        for query in queries {
            if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_DONE {
                    sqlite3_reset(statement);
                }else {
                    print("Table creation fail");
                }
            } else {
                print("Prepration fail");
            }
        }
    }
    
    func deleteExercise() {
        let query = "DELETE FROM exercise";
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Delete data success");
            }
        } else {
            print("Prepartion fail");
        }
    }
    
    func getExerciseCount() -> Int {
        let query = """
        SELECT COUNT(*) FROM exercise;
        """;
        
        var statement: OpaquePointer? = nil;
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                let count = Int(sqlite3_column_int(statement, 0))
                sqlite3_reset(statement);
                return count;
            }
            
        }
        return 0;
    }
    
    func insertExercises(exercises: [Exercise]) {
        if getExerciseCount() != 0 {
            return;
        }
        
        let query = """
        INSERT INTO exercise
        (uid, category, description, equipment, force_type, level, mechanic, name, primary_muscles)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
        """;
        
        var statement: OpaquePointer? = nil;
        sqlite3_exec(db, "BEGIN TRANSACTION", nil, nil, nil);
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            for exercise in exercises {
                sqlite3_bind_text(statement, 1, (exercise.uid! as NSString).utf8String, -1, nil);
                print(exercise.uid!);
                sqlite3_bind_text(statement, 2, (exercise.category! as NSString).utf8String, -1, nil);
                if exercise.exerciseDescription != nil {
                    sqlite3_bind_text(statement, 3, (exercise.exerciseDescription! as NSString).utf8String, -1, nil);
                } else {
                    sqlite3_bind_text(statement, 3, ("" as NSString).utf8String, -1, nil);
                }
                
                if exercise.equipment != nil {
                    sqlite3_bind_text(statement, 4, (exercise.equipment! as NSString).utf8String, -1, nil);
                } else {
                    sqlite3_bind_text(statement, 4, ("" as NSString).utf8String, -1, nil);
                }
                
                if exercise.forceType != nil {
                    sqlite3_bind_text(statement, 5, (exercise.forceType! as NSString).utf8String, -1, nil);
                } else {
                    sqlite3_bind_text(statement, 5, ("" as NSString).utf8String, -1, nil);
                }
                
                sqlite3_bind_text(statement, 6, (exercise.level! as NSString).utf8String, -1, nil);
                if exercise.mechanic != nil {
                    sqlite3_bind_text(statement, 7, (exercise.mechanic! as NSString).utf8String, -1, nil);
                } else {
                    sqlite3_bind_text(statement, 7, ("" as NSString).utf8String, -1, nil);
                }
                sqlite3_bind_text(statement, 8, (exercise.name! as NSString).utf8String, -1, nil);
                sqlite3_bind_text(statement, 9, (exercise.primaryMuscles! as NSString).utf8String, -1, nil);
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Data inserted");
                } else {
                    print("Data is not inserted");
                }
                sqlite3_reset(statement);
            }
            sqlite3_exec(db, "COMMIT TRANSACTION", nil, nil, nil);
            sqlite3_finalize(statement);
        } else {
            print("Query is not as per requirement");
        }
    }
    
    
    func getExercises(_ numberOfExercises: Int) -> [ExerciseEntity] {
        var list = [ExerciseEntity]();
        var counter = 0;
        let query = "SELECT * FROM exercise ORDER BY RANDOM() limit \(numberOfExercises);";
        var statement: OpaquePointer? = nil;
        
        if sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                counter = counter + 1;
                let id = Int(sqlite3_column_int(statement, 0));
                let uid = String(describing: String(cString: sqlite3_column_text(statement, 1)));
                let category = String(describing: String(cString: sqlite3_column_text(statement, 2)));
                let description = String(describing: String(cString: sqlite3_column_text(statement, 3)));
                let equipment = String(describing: String(cString: sqlite3_column_text(statement, 4)));
                let forceType = String(describing: String(cString: sqlite3_column_text(statement, 5)));
                let level = String(describing: String(cString: sqlite3_column_text(statement, 6)));
                let mechanic = String(describing: String(cString: sqlite3_column_text(statement, 7)));
                let name = String(describing: String(cString: sqlite3_column_text(statement, 8)));
                let primaryMuscles = String(describing: String(cString: sqlite3_column_text(statement, 9)));
                
                let model = ExerciseEntity(id: id, uid: uid, category: category, description: description, equipment: equipment, forceType: forceType, level: level, mechanic: mechanic, name: name, primaryMuscle: primaryMuscles);
                list.append(model);
                if counter == numberOfExercises {
                    break;
                }
            }
        }
        return list;
    }
    
    func getExercises(offset: Int, numberOfExercises: Int) -> [ExerciseEntity] {
        var list = [ExerciseEntity]();
        var counter = 0;
        let query = "SELECT * FROM exercise LIMIT \(numberOfExercises) OFFSET \(offset);";
        var statement: OpaquePointer? = nil;
        
        if sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                counter = counter + 1;
                let id = Int(sqlite3_column_int(statement, 0));
                let uid = String(describing: String(cString: sqlite3_column_text(statement, 1)));
                let category = String(describing: String(cString: sqlite3_column_text(statement, 2)));
                let description = String(describing: String(cString: sqlite3_column_text(statement, 3)));
                let equipment = String(describing: String(cString: sqlite3_column_text(statement, 4)));
                let forceType = String(describing: String(cString: sqlite3_column_text(statement, 5)));
                let level = String(describing: String(cString: sqlite3_column_text(statement, 6)));
                let mechanic = String(describing: String(cString: sqlite3_column_text(statement, 7)));
                let name = String(describing: String(cString: sqlite3_column_text(statement, 8)));
                let primaryMuscles = String(describing: String(cString: sqlite3_column_text(statement, 9)));
                
                let model = ExerciseEntity(id: id, uid: uid, category: category, description: description, equipment: equipment, forceType: forceType, level: level, mechanic: mechanic, name: name, primaryMuscle: primaryMuscles);
                list.append(model);
                if counter == numberOfExercises {
                    break;
                }
            }
        }
        return list;
    }
    
    func getExercisePerGroup(muscleGroup: String, offset: Int, numberOfExercises: Int) -> [ExerciseEntity] {
        var list = [ExerciseEntity]();
        var counter = 0;
        if muscleGroup == "All" {
            return getExercises(offset: offset, numberOfExercises: numberOfExercises);
        }
        let query = "SELECT * FROM exercise WHERE primary_muscles='\(muscleGroup)' LIMIT \(numberOfExercises) OFFSET \(offset);";
        var statement: OpaquePointer? = nil;
        
        if sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                counter = counter + 1;
                let id = Int(sqlite3_column_int(statement, 0));
                let uid = String(describing: String(cString: sqlite3_column_text(statement, 1)));
                let category = String(describing: String(cString: sqlite3_column_text(statement, 2)));
                let description = String(describing: String(cString: sqlite3_column_text(statement, 3)));
                let equipment = String(describing: String(cString: sqlite3_column_text(statement, 4)));
                let forceType = String(describing: String(cString: sqlite3_column_text(statement, 5)));
                let level = String(describing: String(cString: sqlite3_column_text(statement, 6)));
                let mechanic = String(describing: String(cString: sqlite3_column_text(statement, 7)));
                let name = String(describing: String(cString: sqlite3_column_text(statement, 8)));
                let primaryMuscles = String(describing: String(cString: sqlite3_column_text(statement, 9)));
                
                let model = ExerciseEntity(id: id, uid: uid, category: category, description: description, equipment: equipment, forceType: forceType, level: level, mechanic: mechanic, name: name, primaryMuscle: primaryMuscles);
                list.append(model);
                if counter == numberOfExercises {
                    break;
                }
            }
        }
        return list;
    }
    
    func searchForAnExerciseInitialLoad(exerciseName: String, offset: Int, numberOfExercises: Int) -> [ExerciseEntity] {
        var list = [ExerciseEntity]();
        var counter = 0;
        let query = "SELECT * FROM exercise WHERE name LIKE ('%\(exerciseName)%') LIMIT \(numberOfExercises) OFFSET \(offset);";
        var statement: OpaquePointer? = nil;
        
        if sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                counter = counter + 1;
                let id = Int(sqlite3_column_int(statement, 0));
                let uid = String(describing: String(cString: sqlite3_column_text(statement, 1)));
                let category = String(describing: String(cString: sqlite3_column_text(statement, 2)));
                let description = String(describing: String(cString: sqlite3_column_text(statement, 3)));
                let equipment = String(describing: String(cString: sqlite3_column_text(statement, 4)));
                let forceType = String(describing: String(cString: sqlite3_column_text(statement, 5)));
                let level = String(describing: String(cString: sqlite3_column_text(statement, 6)));
                let mechanic = String(describing: String(cString: sqlite3_column_text(statement, 7)));
                let name = String(describing: String(cString: sqlite3_column_text(statement, 8)));
                let primaryMuscles = String(describing: String(cString: sqlite3_column_text(statement, 9)));
                
                let model = ExerciseEntity(id: id, uid: uid, category: category, description: description, equipment: equipment, forceType: forceType, level: level, mechanic: mechanic, name: name, primaryMuscle: primaryMuscles);
                list.append(model);
                if counter == numberOfExercises {
                    break;
                }
            }
        }
        return list;
    }
    
    func getWorkouts(_ numberOfWorkouts: Int) -> [ExerciseEntity] {
        var list = [ExerciseEntity]();
        var counter = 0;
        let query = "SELECT * FROM workout LIMIT \(numberOfWorkouts);";
        var statement: OpaquePointer? = nil;
        
        if sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                counter = counter + 1;
                let id = Int(sqlite3_column_int(statement, 0));
                let uid = String(describing: String(cString: sqlite3_column_text(statement, 1)));
                let category = String(describing: String(cString: sqlite3_column_text(statement, 2)));
                let description = String(describing: String(cString: sqlite3_column_text(statement, 3)));
                let equipment = String(describing: String(cString: sqlite3_column_text(statement, 4)));
                let forceType = String(describing: String(cString: sqlite3_column_text(statement, 5)));
                let level = String(describing: String(cString: sqlite3_column_text(statement, 6)));
                let mechanic = String(describing: String(cString: sqlite3_column_text(statement, 7)));
                let name = String(describing: String(cString: sqlite3_column_text(statement, 8)));
                let primaryMuscles = String(describing: String(cString: sqlite3_column_text(statement, 9)));
                
                let model = ExerciseEntity(id: id, uid: uid, category: category, description: description, equipment: equipment, forceType: forceType, level: level, mechanic: mechanic, name: name, primaryMuscle: primaryMuscles);
                list.append(model);
                if counter == numberOfWorkouts {
                    break;
                }
            }
        }
        return list;
    }
    
    func deleteWorkouts() -> Void {
        let query = """
        DELETE FROM workout;
        """;
        
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Delete data success");
            }
        } else {
            print("Prepartion fail");
        }
    }
    
    func insertWorkouts(workouts: WorkoutRequests) -> Void {
//        deleteWorkouts();
        if getExerciseCount() == 0 {
            return;
        }
        if workouts.count == 0 {
            return;
        }
        let query = """
        INSERT OR IGNORE INTO workout
        (uid, name)
        VALUES (?, ?);
        """;
        
        let exerciseQuery = "SELECT id FROM exercise WHERE uid=";
        
        let workoutQuery = "SELECT id FROM workout WHERE uid=";
        
        let insertQuery = """
            INSERT INTO workout_exercise
            (exercise_id, workout_id)
            VALUES (?, ?);
            """
        
        let insertSetQuery = """
            INSERT INTO exercise_set
            (reps, rest_period, weight, workout_exercise_id)
            VALUES (?, ?, ?, ?);
            """;
        
        var statement: OpaquePointer? = nil;
        var emptyWorkout: Bool = false;
        sqlite3_exec(db, "BEGIN TRANSACTION", nil, nil, nil);
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            for workout in workouts {
                sqlite3_bind_text(statement, 1, (workout.uid! as NSString).utf8String, -1, nil);
                sqlite3_bind_text(statement, 2, (workout.name! as NSString).utf8String, -1, nil);
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Data inserted");
                } else {
                    print("Data is not inserted");
                }
                sqlite3_reset(statement);
            }
            sqlite3_exec(db, "COMMIT TRANSACTION", nil, nil, nil);
            sqlite3_finalize(statement);
        } else {
            print("Query is not as per requirement");
        }
        
        statement = nil;
        sqlite3_exec(db, "BEGIN TRANSACTION", nil, nil, nil);
        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            for workout in workouts {
                if workout.exercises?.count == 0 {
                    
                } else {
                    for exercise in workout.exercises! {
                        var exerciseId = -1;
                        var workoutId = -1;
                        if sqlite3_prepare_v2(db, "\(exerciseQuery)'\(exercise.uid!)'", -1, &statement, nil) == SQLITE_OK {
                            if sqlite3_step(statement) == SQLITE_ROW {
                                exerciseId = Int(sqlite3_column_int(statement, 0));
                                sqlite3_reset(statement);
                            }
                        }
                        if sqlite3_prepare_v2(db, "\(workoutQuery)'\(workout.uid!)'", -1, &statement, nil) == SQLITE_OK {
                            if sqlite3_step(statement) == SQLITE_ROW {
                                workoutId = Int(sqlite3_column_int(statement, 0));
                                sqlite3_reset(statement);
                            }
                        }
                        
                        
                        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
                            sqlite3_bind_int(statement, 1, Int32(exerciseId));
                            sqlite3_bind_int(statement, 2, Int32(workoutId));
                            
                            if sqlite3_step(statement) == SQLITE_DONE {
                                print("Data inserted");
                            } else {
                                print("Data is not inserted");
                            }
                            sqlite3_reset(statement);
                        }
                    }
                }
            }
            sqlite3_exec(db, "COMMIT TRANSACTION", nil, nil, nil);
            sqlite3_finalize(statement);
        }
        else {
            print("Query is not as per requirement");
        }
        
        
        statement = nil;
        sqlite3_exec(db, "BEGIN TRANSACTION", nil, nil, nil);
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            for workout in workouts {
                for exercise in workout.exercises! {
                    var exerciseId = -1;
                    var workoutId = -1;
                    var workoutExerciseId = -1;
                    if sqlite3_prepare_v2(db, "\(exerciseQuery)'\(exercise.uid!)'", -1, &statement, nil) == SQLITE_OK {
                        if sqlite3_step(statement) == SQLITE_ROW {
                            exerciseId = Int(sqlite3_column_int(statement, 0));
                            sqlite3_reset(statement);
                        }
                    }
                    if sqlite3_prepare_v2(db, "\(workoutQuery)'\(workout.uid!)'", -1, &statement, nil) == SQLITE_OK {
                        if sqlite3_step(statement) == SQLITE_ROW {
                            workoutId = Int(sqlite3_column_int(statement, 0));
                            sqlite3_reset(statement);
                        }
                    }
                    
                    if sqlite3_prepare_v2(db, "SELECT id FROM workout_exercise WHERE exercise_id=\(exerciseId) AND workout_id=\(workoutId)", -1, &statement, nil) == SQLITE_OK {
                        if sqlite3_step(statement) == SQLITE_ROW {
                            workoutExerciseId = Int(sqlite3_column_int(statement, 0));
                            sqlite3_reset(statement);
                        }
                    }
                    
                    
                    for set in exercise.sets! {
                        // (reps, rest_period, weight, workout_exercise_id)
                        if sqlite3_prepare_v2(db, insertSetQuery, -1, &statement, nil) == SQLITE_OK {
                            sqlite3_bind_int(statement, 1, Int32(set.reps!));
                            sqlite3_bind_int(statement, 2, Int32(set.restPeriod!));
                            sqlite3_bind_int(statement, 3, Int32(set.weight!));
                            sqlite3_bind_int(statement, 4, Int32(workoutExerciseId));
                            
                            if sqlite3_step(statement) == SQLITE_DONE {
                                print("Data inserted");
                            } else {
                                print("Data is not inserted");
                            }
                            sqlite3_reset(statement);
                        }
                    }
                }
            }
            sqlite3_exec(db, "COMMIT TRANSACTION", nil, nil, nil);
            sqlite3_finalize(statement);
        }
        else {
            print("Query is not as per requirement");
        }
        
    }
    
    func getWorkouts(numberOfWorkouts: Int = 0) -> [WorkoutEntity] {
        var workouts = [WorkoutEntity]();
        let query = numberOfWorkouts == 0 ? "SELECT * FROM workout" : "SELECT * FROM workout LIMIT \(numberOfWorkouts)";
        let workoutExerciseQuery = "SELECT * FROM workout_exercise WHERE workout_id=";
        let exerciseSetQuery = "SELECT * FROM exercise_set WHERE workout_exercise_id=";
        let exerciseQuery = "SELECT name FROM exercise WHERE id=";
        var statement: OpaquePointer? = nil;
        var secondInnerStatement: OpaquePointer? = nil;
        var thirdInnerStatement: OpaquePointer? = nil;
        var fourthInnerStatement: OpaquePointer? = nil;
        
        if sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let workoutId = Int(sqlite3_column_int(statement, 0));
                let workoutUid = String(describing: String(cString: sqlite3_column_text(statement, 1)));
                let workoutName = String(describing: String(cString: sqlite3_column_text(statement, 2)));
                
                var workoutExercises = [WorkoutExerciseEntity]();
                if sqlite3_prepare(db, "\(workoutExerciseQuery)'\(workoutId)'", -1, &secondInnerStatement, nil) == SQLITE_OK {
                    while sqlite3_step(secondInnerStatement) == SQLITE_ROW {
                        let workoutExerciseId = Int(sqlite3_column_int(secondInnerStatement, 0));
                        let workoutExercise_exercise_id = Int(sqlite3_column_int(secondInnerStatement, 1));
                        let workoutExercise_workout_id = Int(sqlite3_column_int(secondInnerStatement, 2));
                        
                        var exerciseName: String = "";
                        if sqlite3_prepare(db, "\(exerciseQuery)'\(workoutExercise_exercise_id)'", -1, &fourthInnerStatement, nil) == SQLITE_OK {
                            if sqlite3_step(fourthInnerStatement) == SQLITE_ROW {
                                let name = String(describing: String(cString: sqlite3_column_text(fourthInnerStatement, 0)));
                                exerciseName = name;
                            }
                            sqlite3_reset(fourthInnerStatement);
                        }
                        
                        
                        var exerciseSets = [SetEntity]();
                        if sqlite3_prepare(db, "\(exerciseSetQuery)'\(workoutExerciseId)'", -1, &thirdInnerStatement, nil) == SQLITE_OK {
                            while sqlite3_step(thirdInnerStatement) == SQLITE_ROW {
                                let id = Int(sqlite3_column_int(thirdInnerStatement, 0));
                                let reps = Int(sqlite3_column_int(thirdInnerStatement, 1));
                                let restPeriod = Int(sqlite3_column_int(thirdInnerStatement, 2));
                                let weight = Int(sqlite3_column_int(thirdInnerStatement, 3));
                                
                                let setModel = SetEntity(id: id, reps: reps, weight: weight, rest_period: restPeriod, workout_exercise_id: workoutExerciseId);
                                exerciseSets.append(setModel);
                            }
                            sqlite3_reset(thirdInnerStatement);
                        }
                        
                        
                        let workoutExerciseModel = WorkoutExerciseEntity(id: workoutExerciseId, name: exerciseName, exercise_id: workoutExercise_exercise_id, workout_id: workoutExercise_workout_id, exerciseSets: exerciseSets)
                        
                        
                        workoutExercises.append(workoutExerciseModel);
                    }
                    sqlite3_reset(secondInnerStatement);
                }
                
                
                let workoutModel = WorkoutEntity(id: workoutId, uid: workoutUid, name: workoutName, exercises: workoutExercises);
                workouts.append(workoutModel);
            }
            sqlite3_reset(statement);
        }
        return workouts;
    }
    
    func getExerciseUidByName(name: String) -> String {
        let query = """
        SELECT uid FROM exercise WHERE name=
        """;
        
        var statement: OpaquePointer? = nil;
        if sqlite3_prepare_v2(db, "\(query)'\(name)'", -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                let uid = String(describing: String(cString: sqlite3_column_text(statement, 0)))
                sqlite3_reset(statement);
                return uid;
            }
            
        }
        return "";
    }
}
