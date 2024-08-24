//
//  EditJournalEntryView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/31/24.
//

import Foundation
import SwiftUI

struct EditJournalEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var entry: JournalEntry
    @ObservedObject var viewModel: JournalViewModel
    @Binding var hideBackButton: Bool

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $entry.title)
            }
            
            Section(header: Text("Content")) {
                TextEditor(text: $entry.content)
                    .frame(height: 200)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            
            Section(header: Text("Date")) {
                DatePicker("Select date", selection: $entry.date, displayedComponents: .date)
            }
        }
        .navigationTitle("Edit Entry")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    viewModel.updateEntry(entry: entry)
                    viewModel.fetchEntries()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            hideBackButton = true
        }
        .onDisappear {
            hideBackButton = false
        }
        .navigationBarBackButtonHidden(true)
    }
}
