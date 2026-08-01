//
//  LoginView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/24/24.
//

import SwiftUI

struct LoginView: View {
    @State var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        HeaderView(title: "Calm Capy",
                                   subtitle: "Be calm like a capybara",
                                   angle: 15,
                                   background: Color("PrimaryColor"))
                        .frame(alignment: .center)
                        .offset(y: geometry.size.height * -0.25)
                        
                        Image("Capy Login")
                            .resizable()
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.5)
                            .offset(y: geometry.size.height * 0.02)
                    }
                    .offset(y: geometry.size.height/15)
                    
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
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05)
                    }
                    .padding(.bottom, geometry.size.height * 0.1)
                    
                    VStack {
                        Text("New around here? ")
                        
                        NavigationLink("Create An Account", destination: RegisterView())                    .foregroundStyle(.blue)
                    }
                    .offset(y: -geometry.size.height * 0.07)
                    
                    Spacer()
                }
                .offset(y: geometry.size.height/20)
            }
        }
    }
}

#Preview {
    LoginView()
}
