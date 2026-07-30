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
        let moodCounts = calculateMoodCounts(viewModel: viewModel)

        return VStack {
            ZStack {
                Rectangle()
                    .frame(height: 230)
                    .cornerRadius(10)
                    .foregroundStyle(Color("Default"))
                
                if viewModel.moods.isEmpty {
                    VStack {
                        Text("No mood chart available. \nUse the mood recorder to get started.")
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

    private func calculateMoodCounts(viewModel: MoodViewModel) -> [String: Int] {
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
        let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: 0, hour: -1), to: startOfMonth)!

        var moodCounts: [String: Int] = ["Happy": 0, "Sad": 0, "Fearful": 0, "Angry": 0, "Neutral": 0]

        let filteredMoods = viewModel.moods.filter { $0.timestamp >= startOfMonth && $0.timestamp <= endOfMonth }

        for mood in filteredMoods {
            moodCounts["Happy"]! += mood.happy
            moodCounts["Sad"]! += mood.sad
            moodCounts["Fearful"]! += mood.fearful
            moodCounts["Angry"]! += mood.angry
            moodCounts["Neutral"]! += mood.neutral
        }

        return moodCounts
    }
}

#Preview {
    MoodChartView(viewModel: MoodViewModel())
}
