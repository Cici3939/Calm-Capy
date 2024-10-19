//
//  JournalCard.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/30/24.
//

import SwiftUI

struct JournalCard: View {
    let title: String
    let content: String
    let date: Date
    @State private var isExpanded = false
    @ObservedObject var viewModel = JournalViewModel()
    @StateObject var moodViewModel = MoodViewModel()
    let entryId: String
    let userId: String
    @Binding var hideBackButton: Bool
    @State private var showDeleteAlert = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 2)
                .foregroundStyle(Color("TextColor"))
                .lineLimit(isExpanded ? nil : 1)
                .truncationMode(.tail)
            Text(content)
                .font(.subheadline)
                .lineLimit(isExpanded ? nil : 3)
                .foregroundStyle(Color("TextColor"))
                .truncationMode(.tail)
                .padding(.bottom, 5)
            
            HStack {
                Text("\(date, formatter: dateFormatter)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if let mood = moodViewModel.moods.first(where: { Calendar.current.isDate($0.timestamp, inSameDayAs: date) }) {
                    Circle()
                        .foregroundStyle(colorForMood(mood))
                        .frame(width: 25, height: 25)
                }
                
                Spacer()
                
                NavigationLink(destination: EditJournalEntryView(
                    entry: JournalEntry(id: entryId, title: title, content: content, date: date, userId: userId),
                    viewModel: viewModel,
                    hideBackButton: $hideBackButton
                )) {
                    Image(systemName: "pencil")
                        .foregroundStyle(.blue)
                        .padding(.horizontal)
                }
                Button(action: {
                    showDeleteAlert = true
                }) {
                    Image(systemName: "trash")
                        .foregroundStyle(.blue)
                        .padding(.horizontal)
                }
                .alert(isPresented: $showDeleteAlert, content: {
                    Alert(
                        title: Text("Delete Entry"),
                        message: Text("Are you sure you want to delete this entry? This action can not be undone."),
                        primaryButton: .destructive(Text("Delete")) {
                            viewModel.deleteEntry(entryId: entryId)
                            viewModel.fetchEntries()
                        },
                        secondaryButton: .cancel()
                    )
                })
            }
        }
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .onTapGesture {
            isExpanded.toggle()
        }
    }
    
    func colorForMood(_ mood: Mood) -> Color {
        let maxMood = max(mood.happy, max(mood.sad, max(mood.fearful, max(mood.angry, mood.neutral))))
        
        switch maxMood {
        case 0:
            return Color("Default")
        case mood.happy:
            return .yellow
        case mood.sad:
            return .blue
        case mood.fearful:
            return .purple
        case mood.angry:
            return .red
        case mood.neutral:
            return .green
        default:
            return Color("Default")
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
