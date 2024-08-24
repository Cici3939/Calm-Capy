//
//  HomeView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/25/24.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @StateObject private var viewModel = ProfileViewViewModel()
    
    var body: some View {
        VStack {
            Text("Hi \(viewModel.user?.name ?? "Name")!")
                .font(.system(size: 40))
                .bold()
                .padding(.top)
                .foregroundStyle(Color("TextColor"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            Text("What do you want to do today?")
                .padding(.bottom)
                .foregroundStyle(Color("TextColor"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            VStack {
                MainButton(title: "Breathe with Capy",
                           background: Color("Default"),
                           textColor: Color("TextColor"),
                           imageName: "Chatbot",
                           newView: BreatheView())
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
                
                MainButton(title: "Mood Detector",
                           background: Color("Default"),
                           textColor: Color("TextColor"),
                           imageName: "Chatbot",
                           newView: MoodClassifierView(moods: Mood(happy: 0, sad: 0, fearful: 0, angry: 0, neutral: 0, userId: Auth.auth().currentUser?.uid ?? "", timestamp: Date())))
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
                
                MainButton(title: "Journal",
                           background: Color("Default"),
                           textColor: Color("TextColor"),
                           imageName: "Chatbot",
                           newView: JournalView())
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom)
            }
            .background(Color("PrimaryColor"))
            
            Spacer()
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
}


#Preview {
    HomeView()
}
