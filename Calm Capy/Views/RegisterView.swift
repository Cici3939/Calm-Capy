//
//  RegisterView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/24/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                HeaderView(title: "Register",
                           subtitle: "Start your calm journey",
                           angle: -15,
                           background: Color("SecondaryColor"))
                
                Image("Chatbot")
                    .resizable().frame(width: 210, height: 230)
                    .offset(y: 20)
            }
            
            Form {
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(Color.red)
                }
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                CCButton(title: "Create Account",
                         background: Color("PrimaryColor"))
                {
                    viewModel.register()
                }
                .padding()
            }
            .offset(y: -50)
        }
        .offset(y: 50)
        
        Spacer()
    }
}

#Preview {
    RegisterView()
}
