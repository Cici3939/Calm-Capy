//
//  MoodChartView.swift
//  Calm Capy
//
//  Created by Cici Xing on 8/5/24.
//

import SwiftUI
import Charts

struct MoodChartView: View {
    @ObservedObject var viewModel: MoodViewModel

    var body: some View {
        VStack {
            
            ZStack {
                Rectangle()
                    .frame(height: 230)
                    .cornerRadius(10)
                    .foregroundStyle(Color("Default"))
                
                if viewModel.moods.isEmpty {
                    VStack {
                        Text("No mood chart available. \nUse the mood detector to get started.")
                            .foregroundStyle(Color("TextColor"))
                            .padding()
                            .frame(width: 300, height: 200, alignment: .center)
                    }
                } 
                else {
                    Chart {
                        ForEach(viewModel.moods, id: \.userId) { mood in
                            BarMark(
                                x: .value("Mood", "Happy"),
                                y: .value("Count", mood.happy)
                            )
                            .foregroundStyle(.yellow)
                            
                            BarMark(
                                x: .value("Mood", "Sad"),
                                y: .value("Count", mood.sad)
                            )
                            .foregroundStyle(.blue)
                            
                            BarMark(
                                x: .value("Mood", "Fearful"),
                                y: .value("Count", mood.fearful)
                            )
                            .foregroundStyle(.purple)
                            
                            BarMark(
                                x: .value("Mood", "Angry"),
                                y: .value("Count", mood.angry)
                            )
                            .foregroundStyle(.red)
                            
                            BarMark(
                                x: .value("Mood", "Neutral"),
                                y: .value("Count", mood.neutral)
                            )
                            .foregroundStyle(.green)
                        }
                    }
                    .frame(height: 200)
                    .padding()
                }
            }
            .padding()
            .offset(y: 10)
            
            Text("<- Swipe to see mood count")
                .foregroundStyle(Color("TextColor"))
                .font(.system(size: 10))
                .offset(y: -5)
        }
    }
}

#Preview {
    MoodChartView(viewModel: MoodViewModel())
}
