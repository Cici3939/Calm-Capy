//
//  MoodClassifierView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/21/24.
//

import SwiftUI
import FirebaseAuth

struct MoodClassifierView: View {
    @StateObject private var viewModel = AudioClassifierViewModel()
    @StateObject private var moodViewModel = MoodViewModel()
    @State var moods: Mood
    @State var mood: String = ""
    @State private var isUpdated = false
    
    @State private var showHappyView = false
    @State private var showSadView = false
    @State private var showNeutralView = false
    @State private var showAngryView = false
    @State private var showFearfulView = false

    var body: some View {
        VStack {
            Spacer()
            Text("Mood Detection")
                .font(.largeTitle)
                .foregroundStyle(Color("TextColor"))
                .bold()
                .padding()
            
            Text("Detection Result:")
                .font(.headline)
                .foregroundStyle(Color("TextColor"))
                .padding()
            
            Text("\(viewModel.result)")
                .font(.title)
                .foregroundStyle(Color("TextColor"))
                .padding()
            
            Button("Start Detection") {
                viewModel.clearResults()
                viewModel.startAudioEngine()
                viewModel.classifySound()
            }
            .padding()
            .frame(maxWidth: 300)
            .background(Color("PrimaryColor"))
            .foregroundStyle(.white)
            .cornerRadius(10.0)
            
            Button(action: {
                mood = viewModel.stopAudioEngine()
                moodViewModel.updateMood(mood: mood)
                
                switch mood {
                    case "Happy": showHappyView = true
                    case "Neutral": showNeutralView = true
                    case "Sad": showSadView = true
                    case "Angry": showAngryView = true
                    case "Fearful": showFearfulView = true
                    default: break
                }
                
            }) {
                Text("Stop Detection")
                    .padding()
                    .frame(maxWidth: 300)
                    .background(Color("PrimaryColor"))
                    .foregroundStyle(.white)
                    .cornerRadius(10.0)
            }
            
            Spacer()
            
            Text("Or choose one from here:")
                .foregroundStyle(Color("TextColor"))
            
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
                    }
                }) {
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
            
            NavigationLink(destination: HappyView(), isActive: $showHappyView) { EmptyView() }
            NavigationLink(destination: SadView(), isActive: $showSadView) { EmptyView() }
            NavigationLink(destination: NeutralView(), isActive: $showNeutralView) { EmptyView() }
            NavigationLink(destination: AngryView(), isActive: $showAngryView) { EmptyView() }
            NavigationLink(destination: FearfulView(), isActive: $showFearfulView) { EmptyView() }

        }.onAppear {
            viewModel.requestMicrophoneAccess()
        }
    }
}

#Preview {
    MoodClassifierView(moods: Mood(happy: 0, sad: 0, fearful: 0, angry: 0, neutral: 0, userId: "", timestamp: Date()))
}
