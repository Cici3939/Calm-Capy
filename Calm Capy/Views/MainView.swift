//
//  MainView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/25/24.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab = 3
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem{
                    Image(systemName: "house.circle")
                        .foregroundStyle(Color("PrimaryColor"))
                    
                    Text("Home")
                        .foregroundStyle(Color("TextColor"))
                }

            ChatbotView()
                .tabItem{
                    Image(systemName: "message.circle")
                        .foregroundStyle(Color("PrimaryColor"))
                    
                    Text("Chatbot")
                        .foregroundStyle(Color("TextColor"))
                }
            
            StatsView()
                .tabItem{
                    Image(systemName: "calendar.circle")
                        .foregroundStyle(Color("PrimaryColor"))
                    
                    Text("Stats")
                        .foregroundStyle(Color("TextColor"))
                }
            
            ProfileView()
                .tabItem{
                    Image(systemName: "person.crop.circle")
                        .foregroundStyle(Color("PrimaryColor"))
                    
                    Text("Profile")
                        .foregroundStyle(Color("TextColor"))
                }
        }
        .background(.white)
    }
}

#Preview {
    MainView()
}
