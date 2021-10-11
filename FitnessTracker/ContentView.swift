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
    @State var showSplashScreen: Bool = true;
    var body: some View {
        VStack {
            if showSplashScreen {
                LoadingView();
            } else {
                if loginAnimation {
                    LoadingView();
                } else {
                    if !loggedIn {
                        LoginView();
                    }
                    else {
                        MainView().onAppear(perform: {
                            CronService().cronStart();
                        })
                    }
                }
            }
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.showSplashScreen = false;
            })
            Repository.shared;
            if loggedIn {
                JwtService().checkTokenValidity();
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

