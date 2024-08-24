//
//  StatsView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/28/24.
//

import SwiftUI
import Charts


struct StatsView: View {
    @StateObject private var viewModel = MoodViewModel()

    var body: some View {
        VStack {
            Spacer()
            
            MoodCalendarView(viewModel: viewModel)
                .offset(y: 30)

            Spacer()
            
            Text("This Month:")
                .foregroundStyle(Color("TextColor"))
                .font(.system(size: 30))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .offset(y: 30)

            TabView {
                MoodCountView(viewModel: viewModel)
                
                MoodChartView(viewModel: viewModel)
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                viewModel.fetchMoods()
            }

            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 91)
                .foregroundStyle(Color("Default"))
        }
        .background(Color("PrimaryColor")).ignoresSafeArea()
    }
}

#Preview {
    StatsView()
}
