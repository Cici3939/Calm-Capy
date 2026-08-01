//
//  RegisterView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/24/24.
//

import SwiftUI

struct RegisterView: View {
    @State var viewModel = RegisterViewViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    HeaderView(title: "Register",
                               subtitle: "Start your calm journey",
                               angle: -15,
                               background: Color("SecondaryColor"))
                    .frame(alignment: .center)
                    .offset(y: geometry.size.height * -0.27)
                    
                    Image("Capy Register")
                        .resizable()
                        .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.5)
                        .offset(y: geometry.size.height * 0.02)
                }
                .offset(y: geometry.size.height/100)
                
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
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05)
                }
                .offset(y: -geometry.size.height * 0.07)
                
                Spacer()
            }
            .offset(y: geometry.size.height/20)
        }
    }
}

#Preview {
    RegisterView()
}
