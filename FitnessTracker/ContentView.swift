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
    var body: some View {
        // defaults.value(forKey: "tokens") == nil
        if !loggedIn {
            LoginView();
        }
        else {
            MainView();
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

