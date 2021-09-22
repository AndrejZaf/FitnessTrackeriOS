//
//  LoginView.swift
//  FitnessTracker
//
//  Created by Zaf on 19.9.21.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginViewModel = LoginViewModel();
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer();
                
                TextField("Email", text: $loginViewModel.email)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.horizontal);
                
                SecureField("Password", text: $loginViewModel.password)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding();
                
                
                CustomButton(title: "Login", disabled: false, backgroundColor: Color.blue, foregroundColor: Color.white, action: {
                    loginViewModel.login();
                });
                
                HStack {
                    NavigationLink(
                        destination: ForgotPasswordView(),
                        label: {
                            Text("Forgor your password?")
                                .foregroundColor(.secondary)
                            Text("Click here")
                        })
                }
                
                Spacer();
                
                Divider();
                HStack {
                    NavigationLink(
                        destination: SignUpView(),
                        label: {
                            Text("Don't have an account?")
                                .foregroundColor(.secondary);
                            Text("Sign Up")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    });
                    
                    
                }.padding();
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
