//
//  ProfileView.swift
//  FitnessTracker
//
//  Created by Zaf on 21.9.21.
//

import SwiftUI

struct ProfileView: View {
    let defaults = UserDefaults.standard;
    var body: some View {
        VStack {
            Text("Profile View")
            Button(action: {
                defaults.removeObject(forKey: "tokens");
                defaults.removeObject(forKey: "loggedIn");
            }, label: {
                Text("Logout");
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
