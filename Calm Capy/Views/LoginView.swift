//
//  LoginView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/24/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                ZStack {
                    HeaderView(title: "Calm Capy",
                               subtitle: "Be calm like a capybara",
                               angle: 15,
                               background: Color("PrimaryColor"))
                    Image("Capy Login")
                        .resizable().frame(width: 210, height: 230)
                        .offset(y: 10)
                }
                
                
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundStyle(Color.red)
                    }
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    CCButton(title: "Log In", 
                             background: Color("PrimaryColor"))
                    {
                        viewModel.login()
                        
                    }
                    .padding()
                }
                .padding(.bottom, -50)
                .offset(y: -50)
                                
                VStack {
                    Text("New around here? ")
                    
                    NavigationLink("Create An Account", destination: RegisterView())                    .foregroundStyle(.blue)
                }
                .padding()
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    LoginView()
}
