//
//  ProfileView.swift
//  FitnessTracker
//
//  Created by Zaf on 21.9.21.
//

import SwiftUI

struct ProfileView: View {
    let defaults = UserDefaults.standard;
    @State private var measurementSelect: String = "Imperial";
    @State private var themeToggle: Bool = false;
    let measurementSystems = ["Imperial", "Metric"];
    var body: some View {
        VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(height: 40)
                    HStack {
                        Toggle("Theme Select", isOn: $themeToggle)
                    }.padding(.horizontal);
                }
            
            ZStack {
                Rectangle()
                    .fill(Color.yellow)
                    .frame(height: 40)
                HStack {
                Picker("Select a measurement system", selection: $measurementSelect) {
                    ForEach(measurementSystems, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 10)
                .padding(.top, 10)
                .padding(.horizontal);
                }
            }
            
            Button(action: {
                defaults.removeObject(forKey: "tokens");
                defaults.removeObject(forKey: "loggedIn");
                Repository.shared.deleteWorkouts();
            }, label: {
                Text("Logout");
            })
            Spacer();
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
