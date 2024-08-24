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

    var body: some View {
        VStack {
            Text("Sound Classification")
                .font(.largeTitle)
                .padding()
            
            Text("Classification Result:")
                .font(.headline)
                .padding()
            
            Text("\(viewModel.result)")
                .font(.title)
                .padding()
            
            Button("Start Classification") {
                viewModel.clearResults()
                viewModel.startAudioEngine()
                viewModel.classifySound()
            }
            .padding()
            .frame(maxWidth: 300)
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(10.0)
            
            Button(action: {
                mood = viewModel.stopAudioEngine()
                            
                moodViewModel.updateMood(mood: mood)
            }) {
                Text("Stop Classification")
                    .padding()
                    .frame(maxWidth: 300)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10.0)
            }
            
        }.onAppear {
            viewModel.requestMicrophoneAccess()
        }
    }
}

#Preview {
    MoodClassifierView(moods: Mood(happy: 0, sad: 0, fearful: 0, angry: 0, neutral: 0, userId: "", timestamp: Date()))
}
