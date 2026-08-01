//
//  ContentView.swift
//  Calm Capy 2026
//
//  Created by Cici Xing on 7/24/26, replaced with code from 7/21/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ContentViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // signed in
            MainView()
            
        } else{
            // not signed in
            LoginView()
        }
    }
    
}

#Preview {
    ContentView()
}
