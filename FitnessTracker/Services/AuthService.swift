//
//  AuthService.swift
//  FitnessTracker
//
//  Created by Zaf on 20.9.21.
//

import Foundation


enum AuthenticationError: Error {
    case invalidCredentials
    case userNotFound
    case passwordMismatch
    case userAlreadyExists
    case custom(errorMessage: String)
}



class AuthService {
    func login(email: String, password: String, completion: @escaping (Result<[String: String?], AuthenticationError>) -> Void) -> Void {
        guard let url = URL(string: ApiConstants.apiUrl + ApiConstants.loginEndpoint) else {
            completion(.failure(.custom(errorMessage: ApiConstants.badUrl)));
            return;
        }
        
        let body = LoginBodyRequest(username: email, password: password);
        
        var requestBodyComponents = URLComponents()
        requestBodyComponents.queryItems = [URLQueryItem(name: "username", value: body.username),
                                            URLQueryItem(name: "password", value: body.password)];
        
        var request = URLRequest(url: url);
        request.httpMethod = "POST";
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type");
        request.httpBody = requestBodyComponents.query?.data(using: .utf8);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")));
                return;
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginBodyResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return;
            }
            
            let tokens = ["accessToken": loginResponse.accessToken, "refreshToken": loginResponse.refreshToken];
            completion(.success(tokens));
            
        }.resume();
    }
    
    func forgotPassword(email: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) -> Void {
        guard let url = URL(string: ApiConstants.apiUserEndpoint + ApiConstants.forgotPassword) else {
            completion(.failure(.custom(errorMessage: ApiConstants.badUrl)));
            return;
        };
        let body = ForgotPasswordRequest(email: email);
        var request = URLRequest(url: url);
        request.httpMethod = "POST";
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        request.httpBody = try? JSONEncoder().encode(body);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")));
                return;
            }
            
            guard let forgotPasswordResponse = try? JSONDecoder().decode(ForgotPasswordResponse.self, from: data) else {
                completion(.failure(.userNotFound));
                return;
            }
            
            completion(.success(forgotPasswordResponse.email));
        }.resume();
    }
    
    func signUp(email: String, password: String, matchingPassword: String, measurementSystem: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) -> Void {
        
        if password != matchingPassword {
            completion(.failure(.passwordMismatch))
        }
        
        guard let url = URL(string: ApiConstants.apiUserEndpoint) else {
            completion(.failure(.custom(errorMessage: ApiConstants.badUrl)));
            return;
        };
        
        let body = UserSignupRequest(email: email, password: password, measurementSystem: measurementSystem);
        var request = URLRequest(url: url);
        request.httpMethod = "POST";
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        request.httpBody = try? JSONEncoder().encode(body);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")));
                return;
            }
            
            guard let userSignupResponse = try? JSONDecoder().decode(UserSignupResponse.self, from: data) else {
                completion(.failure(.userAlreadyExists));
                return;
            }
            
            completion(.success(userSignupResponse.email));
        }.resume();
    }
    
    
    func refreshToken() -> Void {
        let defaults = UserDefaults.standard;
        let tokens = defaults.dictionary(forKey: "tokens");
        let accessToken = tokens!["accessToken"];
        
        guard let url = URL(string: "http://localhost:8080/api/user/token/refresh") else {
            return;
        }

        
        var request = URLRequest(url: url);
        request.httpMethod = "GET";
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization");
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                return;
            }
            
            
            guard let loginResponse = try? JSONDecoder().decode(LoginBodyResponse.self, from: data) else {
                defaults.removeObject(forKey: "tokens");
                defaults.removeObject(forKey: "loggedIn");
                return;
            }
            
            let tokens = ["accessToken": loginResponse.accessToken, "refreshToken": loginResponse.refreshToken];
            defaults.setValue(["accessToken": tokens["accessToken"]!!, "refreshToken": tokens["refreshToken"]!!], forKey: "tokens");
            RegulatorService.shared.release();
        }.resume();
        
    }
}
