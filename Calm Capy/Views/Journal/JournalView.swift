//
//  JournalView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/28/24.
//

import SwiftUI

struct JournalView: View {
    @ObservedObject var viewModel = JournalViewModel()
    @State private var hideBackButton = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(viewModel.entries) { entry in
                    JournalCard(
                        title: entry.title,
                        content: entry.content,
                        date: entry.date,
                        viewModel: viewModel,
                        entryId: entry.id ?? "",
                        userId: entry.userId,
                        hideBackButton: $hideBackButton
                    )
                    .padding(.horizontal)
                    .background(Color("Default"))
                    .cornerRadius(10)
                    .shadow(color: Color("DefaultOpp"), radius: 5)
                    .padding(.horizontal)
                    }
                }
                .navigationTitle("Journal")
                .navigationTitleColor(Color("TextColor"))
                .navigationBarBackButtonHidden(hideBackButton)
                
                Spacer()
                
                HStack {
                    Spacer()
                    NavigationLink(destination: AddJournalEntryView(viewModel: viewModel, hideBackButton: $hideBackButton)) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                            .background(Color("PrimaryColor"))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding()
                }
            }
            .padding(.top)
            .padding(.trailing)
            .background(Color("PrimaryColor"))
        }
        .navigationBarBackButtonHidden(hideBackButton)
        .foregroundStyle(Color("TextColor"))
        .onAppear {
            hideBackButton = false
        }
    }
}

#Preview {
    JournalView()
}
