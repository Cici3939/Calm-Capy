//
//  AddJournalEntryView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/30/24.
//

import SwiftUI

struct AddJournalEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var content = ""
    @State private var date = Date()
    @ObservedObject var viewModel: JournalViewModel
    @Binding var hideBackButton: Bool
    
    @State private var showAlert = false

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $title)
            }
            
            Section(header: Text("What is on your mind?")) {
                TextEditor(text: $content)
                    .frame(height: 200)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            
            Section(header: Text("Date")) {
                DatePicker("Select date", selection: $date, displayedComponents: .date)
            }
        }
        .navigationTitle("New Entry")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if title.isEmpty && content.isEmpty {
                        showAlert = true
                    } else {
                        viewModel.addNewEntry(title: title, content: content, date: date)
                        viewModel.fetchEntries()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .onAppear {
            hideBackButton = true
        }
        .onDisappear {
            hideBackButton = false
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Input Required"),
                message: Text("Please enter a title and content for your entry."),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AddJournalEntryView(viewModel: JournalViewModel(), hideBackButton: .constant(false))
}
