//
//  FocusModeView.swift
//  FitnessTracker
//
//  Created by Zaf on 7.10.21.
//

import SwiftUI

struct FocusModeView: View {
    @State var workout: WorkoutEntity;
    @State var exerciseIndex: Int = 0;
    @State var setIndex: Int = 0;
    @State var startTimer: Bool = false;
    @State var timeRemaining: Int = 0;
    @State var workoutFinished: Bool = false;
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect();
    @Environment(\.presentationMode) var presentationMode;
    var body: some View {
        VStack {
            if workoutFinished {
                if startTimer {
                    Spacer();
                    Text("\(timeRemaining) seconds").font(.title).fontWeight(.bold).onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining = timeRemaining - 1;
                        } else {
                            startTimer = false;
                        }
                    }
                    Spacer();
                    Button(action: {
                        startTimer = false;
                    }, label: {
                        Text("Skip Rest Period")
                    }).padding()
                } else {
                    Text("Congratulations, you completed your workout!").font(.title).fontWeight(.bold);
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss();
                    }, label: {
                        Text("Finish Workout")
                    })
                }
            }
            else {
                Spacer();
                VStack {
                    if startTimer {
                        Text("\(timeRemaining) seconds").fontWeight(.bold).onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining = timeRemaining - 1;
                            } else {
                                startTimer = false;
                            }
                        }
                    }
                    else {
                        Text("\(workout.exercises[exerciseIndex].exerciseSets[setIndex].weight) kg").font(.title).fontWeight(.bold).padding();
                        Text("\(workout.exercises[exerciseIndex].name)").font(.title).fontWeight(.bold).padding();
                        Text("\(workout.exercises[exerciseIndex].exerciseSets[setIndex].reps) Reps").font(.title2).padding();
                    }
                }.frame(alignment: .center)
                Spacer();
                VStack {
                    HStack {
                        
                        ForEach(0..<workout.exercises.indices.count, id: \.self) { index in
                                if self.exerciseIndex == index {
                                    Image(systemName: "circle.fill");
                                } else {
                                    Image(systemName: "circle");
                                }
                        }
                    }
                    HStack {
                        if !startTimer {
                            Button(action: {
                                if setIndex - 1 >= 0 {
                                    setIndex = setIndex - 1;
                                } else {
                                    setIndex = 0;
                                    if exerciseIndex - 1 >= 0 {
                                        exerciseIndex = exerciseIndex - 1;
                                        setIndex = workout.exercises[exerciseIndex].exerciseSets.count - 1;
                                    }
                                }
        
                            }, label: {
                                Text("Previous set")
                            }).padding()
                            
                            Button(action: {
                                if setIndex + 1 <= workout.exercises[exerciseIndex].exerciseSets.count - 1 {
                                    setIndex = setIndex + 1;
                                    startTimer = true;
                                    timeRemaining = workout.exercises[exerciseIndex].exerciseSets[setIndex].rest_period;
                                } else {
                                    setIndex = 0;
                                    timeRemaining = workout.exercises[exerciseIndex].exerciseSets[setIndex].rest_period;
                                    if exerciseIndex + 1 <= workout.exercises.count - 1 {
                                        exerciseIndex = exerciseIndex + 1;
                                    } else {
                                        workoutFinished = true;
                                    }
                                    
                                    startTimer = true;
                                }

                            }, label: {
                                Text("Next set")
                            }).padding()
                        }
                        else {
                            Button(action: {
                                startTimer = false;
                            }, label: {
                                Text("Skip Rest Period")
                            }).padding()
                        }
                    }
                }
            }
        }
    }
}

struct FocusModeView_Previews: PreviewProvider {
    static var previews: some View {
        FocusModeView(workout: EntityUtils.workout)
    }
}
