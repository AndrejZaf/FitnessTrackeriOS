//
//  SignUpView.swift
//  FitnessTracker
//
//  Created by Zaf on 20.9.21.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>;
    @StateObject private var signUpViewModel = SignUpViewModel();
    @State private var emailAddress = "";
    @State private var password = "";
    @State private var confirmPassword = "";
    @State private var selection = "";
    @State private var showAlert = false;
    
    let measurementSystems = ["Imperial", "Metric"];
    
    var body: some View {
        VStack {
            Spacer();
            VStack {
            if signUpViewModel.incorrectForm {
                Text("Incorrect Vaues").foregroundColor(.red).fontWeight(.bold);
            }
            TextField("Email", text: $signUpViewModel.email)
                .textFieldStyle(CustomTextFieldStyle())
                .padding(.horizontal);
            
            SecureField("Password", text: $signUpViewModel.password)
                .textFieldStyle(CustomTextFieldStyle())
                .padding(.top)
                .padding(.horizontal);
            
            SecureField("Confirm Password", text: $signUpViewModel.matchingPassword)
                .textFieldStyle(CustomTextFieldStyle())
                .padding(.vertical)
                .padding(.horizontal);
            
            
            Text("Select a Measurement System")
                .font(.subheadline)
                .padding(.bottom, 0);
            
            Picker("Select a measurement system", selection: $signUpViewModel.measurementSystem) {
                ForEach(measurementSystems, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 10)
            .padding(.horizontal);
            
            CustomButton(title: "Sign Up", disabled: false, backgroundColor: Color.black, foregroundColor: Color.white, action: {
                signUpViewModel.signUp();
            }).alert(isPresented: Binding<Bool>(
                get: { signUpViewModel.isFinished }, set: {_ in }
            )) {
                Alert(title: Text("Email Sent"), message: Text("We sent an email to \(signUpViewModel.registeredEmail) with a verification link. Please verify your account before logging in."), dismissButton: .default(Text("Ok"), action: {
                    self.mode.wrappedValue.dismiss();
                }));
            }
            
            HStack {
            Text("By signing up, you agree with our")
                .font(.subheadline)
                .foregroundColor(.secondary);
            }
            Text("Terms of Service")
                .font(.subheadline)
                .foregroundColor(.primary);
            }
            Spacer();
            
        }.toast(isPresenting: $signUpViewModel.isLoading, duration: 2, alert: { AlertToast(displayMode: .hud, type: .loading, title: "Loading") })
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
