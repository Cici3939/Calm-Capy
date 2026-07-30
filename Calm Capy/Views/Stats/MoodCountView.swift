//
//  MoodCountView.swift
//  Calm Capy
//
//  Created by Cici Xing on 8/5/24.
//

import SwiftUI

struct MoodCountView: View {
    @ObservedObject var viewModel: MoodViewModel

    var body: some View {
        let moodCounts = calculateMoodCounts(viewModel: viewModel)

        return VStack {
            ZStack {
                Rectangle()
                    .cornerRadius(10)
                    .foregroundStyle(Color("Default"))
                    .frame(height: 230)
                
                if viewModel.moods.isEmpty {
                    VStack(alignment: .leading) {
                        MoodRowView(color: .yellow, mood: "Happy", count: 0)
                        MoodRowView(color: .blue, mood: "Sad", count: 0)
                        MoodRowView(color: .purple, mood: "Fearful", count: 0)
                        MoodRowView(color: .red, mood: "Angry", count: 0)
                        MoodRowView(color: .green, mood: "Neutral", count: 0)
                    }
                } else {
                    VStack(alignment: .leading) {
                        MoodRowView(color: .yellow, mood: "Happy", count: moodCounts["Happy"] ?? 0)
                        MoodRowView(color: .blue, mood: "Sad", count: moodCounts["Sad"] ?? 0)
                        MoodRowView(color: .purple, mood: "Fearful", count: moodCounts["Fearful"] ?? 0)
                        MoodRowView(color: .red, mood: "Angry", count: moodCounts["Angry"] ?? 0)
                        MoodRowView(color: .green, mood: "Neutral", count: moodCounts["Neutral"] ?? 0)
                    }
                }
            }
            .padding()
            .offset(y: 10)
            
            Text("Swipe to see chart ->")
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

struct MoodRowView: View {
    var color: Color
    var mood: String
    var count: Int

    var body: some View {
        HStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundStyle(color)
                .padding(.trailing)
            Text("\(mood): \(count)")
                .foregroundStyle(Color("TextColor"))
        }
    }
}

#Preview {
    MoodCountView(viewModel: MoodViewModel())
}
