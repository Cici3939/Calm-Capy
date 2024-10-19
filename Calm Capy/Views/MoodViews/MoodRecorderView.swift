//
//  MoodRecorderView.swift
//  Calm Capy
//
//  Created by Cici Xing on 9/28/24.
//

import SwiftUI
import FirebaseAuth

struct MoodRecorderView: View {
    @StateObject private var moodViewModel = MoodViewModel()
    @State private var isUpdated: Bool = false
    
    var body: some View {
        
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                    .foregroundStyle(Color("Default"))
                    .cornerRadius(10)
                    .frame(width: 370, height: 390)
                    .offset(y: 10)
                
                VStack {
                    Text("Choose your mood:")
                        .foregroundStyle(Color("TextColor"))
                        .font(.system(size: 30))
                        .bold()
                    
                    HStack {
                        NavigationLink(destination: HappyView().onAppear{
                            if !isUpdated {
                                isUpdated = true
                                moodViewModel.updateMood(mood: "Happy")
                            }
                        }) {
                            VStack {
                                Image("HappyCapy")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text("Happy")
                                    .foregroundStyle(Color("TextColor"))
                            }
                        }
                        NavigationLink(destination: SadView().onAppear {
                            if !isUpdated {
                                isUpdated = true
                                moodViewModel.updateMood(mood: "Sad")
                            }
                        }) {
                            
                            VStack {
                                Image("SadCapy")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text("Sad")
                                    .foregroundStyle(Color("TextColor"))
                                
                            }
                        }
                    }
                    HStack {
                        NavigationLink(destination: NeutralView().onAppear{
                            if !isUpdated {
                                isUpdated = true
                                moodViewModel.updateMood(mood: "Neutral")
                            }
                        }) {
                            VStack {
                                Image("NeutralCapy")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text("Neutral")
                                    .foregroundStyle(Color("TextColor"))
                                
                            }
                        }
                        NavigationLink(destination: AngryView().onAppear {
                            if !isUpdated {
                                isUpdated = true
                                moodViewModel.updateMood(mood: "Angry")
                            }                        }) {
                            VStack {
                                Image("AngryCapy")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text("Angry")
                                    .foregroundStyle(Color("TextColor"))
                                
                            }
                        }
                        NavigationLink(destination: FearfulView().onAppear {
                            if !isUpdated {
                                isUpdated = true
                                moodViewModel.updateMood(mood: "Fearful")
                            }
                        }) {
                            VStack {
                                Image("FearfulCapy")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text("Fearful")
                                    .foregroundStyle(Color("TextColor"))
                                
                            }
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
            
            NavigationLink(destination: MoodClassifierView(moods: Mood(happy: 0, sad: 0, fearful: 0, angry: 0, neutral: 0, userId: Auth.auth().currentUser?.uid ?? "", timestamp: Date()))) {
                VStack {
                    Text("Or try our audio mood detection here:")
                        .foregroundStyle(Color("TextColor"))
                    ZStack {
                        Rectangle()
                            .frame(width: 300, height: 50)
                            .cornerRadius(10)
                            .padding()
                            .foregroundStyle(Color("Default"))
                        Text("Mood Detection")
                            .foregroundStyle(Color("TextColor"))
                    }
                }
            }
            
            Spacer()
        }
        .background(Color("PrimaryColor")).ignoresSafeArea()
    }
}

#Preview {
    MoodRecorderView()
}
