//
//  ContentView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/21/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()
    
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
