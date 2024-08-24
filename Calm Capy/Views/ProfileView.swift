//
//  ProfileView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/24/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading Profile...")
                }
            }
            .onAppear() {
                viewModel.fetchUser()
            }
            
        }
    }
    @ViewBuilder
    func profile(user: User) -> some View {
        ZStack {
            //Bg pic
            //Image("Chatbot")
                //.offset(y: -100)
            Rectangle()
                .foregroundStyle(Color("SecondaryColor"))
                .frame(width: 1000, height: 350)
                .offset(y: -100)
            
            //Profile pic
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color("PrimaryColor"))
                .background(Color("TextColor"))
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(width: 125, height: 125)
                .offset(y: 70)
                .padding()
        }
        
        VStack(alignment: .leading) {
            HStack {
                Text("Name: ")
                    .bold()
                
                Text(user.name)
            }
            .padding()

            HStack {
                Text("Email: ")
                    .bold()

                Text(user.email)
            }
            .padding()

            HStack {
                Text("Member Since: ")
                    .bold()

                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()

        }
        .padding()
        
        Button("Log Out") {
            viewModel.logOut()
        }
        .tint(.red)
        .padding()
        
        Spacer()

    }
    
}

#Preview {
    ProfileView()
}
