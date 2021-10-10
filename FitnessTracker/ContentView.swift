//
//  ContentView.swift
//  FitnessTracker
//
//  Created by Zaf on 4.9.21.
//

import SwiftUI

struct ContentView: View {
    let defaults = UserDefaults.standard;
    @AppStorage("loggedIn") var loggedIn: Bool = false;
    @AppStorage("loginAnimation") var loginAnimation: Bool = false;
    
    var body: some View {
        VStack {
            // defaults.value(forKey: "tokens") == nil
            if loginAnimation {
                LoadingView();
            } else {
                if !loggedIn {
                    LoginView();
                }
                else {
                    MainView().onAppear(perform: {
                        CronService().cronStart();
                    });
                }
            }
            
        }.onAppear(perform: {
            Repository.shared;
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

