//
//  LoginViewViewModel.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/24/24.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                print("Error code: \(error.code)")
                if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                    switch errorCode {
                    case .invalidEmail:
                        self.errorMessage = "Email not found."
                    case .wrongPassword:
                        self.errorMessage = "Wrong password."
                    case .userNotFound:
                        self.errorMessage = "User not found."
                    case .userDisabled:
                        self.errorMessage = "User account is disabled."
                    case .operationNotAllowed:
                        self.errorMessage = "Operation not allowed."
                    case .tooManyRequests:
                        self.errorMessage = "Too many requests. Please try again later."
                    default:
                        self.errorMessage = "Error: \(error.localizedDescription)"
                    }
                } else {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            } else {
                self.errorMessage = ""
            }
        }
    }

    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        return true
    }

}
