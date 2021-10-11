//
//  ProfileView.swift
//  FitnessTracker
//
//  Created by Zaf on 21.9.21.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var profileViewModel = ProfileViewModel();
    let measurementSystems = ["Imperial", "Metric"];
    
    var body: some View {
        VStack {
            Form {
                Picker("Select a measurement system", selection: $profileViewModel.selection) {
                    ForEach(measurementSystems, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: profileViewModel.selection, perform: { value in
                    profileViewModel.changeMeasurementSystem(system: profileViewModel.selection)
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 10)
                .padding(.top, 10)
                .padding(.horizontal);
                
                Button(action: {
                    profileViewModel.sync();
                }, label: {
                    Text("Synchronize")
                })
            }
            
            Spacer();
            
            CustomButton(title: "Logout", backgroundColor: .black, foregroundColor: .white, action: {
                profileViewModel.logout();
            })
        }.toast(isPresenting: $profileViewModel.showLoading, duration: 2, alert: { AlertToast(displayMode: .hud, type: .loading, title: "Loading") })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
