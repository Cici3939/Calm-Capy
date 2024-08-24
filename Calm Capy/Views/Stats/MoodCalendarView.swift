//
//  MoodCalendarView.swift
//  Calm Capy
//
//  Created by Cici Xing on 8/6/24.
//

import SwiftUI

struct MoodCalendarView: View {
    @ObservedObject var viewModel: MoodViewModel
    @State private var currentDate = Date()
    @State private var selectedDate: Date?
    
    let calendar = Calendar.current
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color("BorderColor"))
                .cornerRadius(10)
                .frame(width: 370, height: 390)
                .offset(y: 10)
            
            Rectangle()
                .foregroundStyle(Color("Default"))
                .cornerRadius(10)
                .frame(height: 380)
                .offset(y: 10)
                .padding()
            
            Rectangle()
                .foregroundStyle(Color("CalendarOne"))
                .cornerRadius(10)
                .frame(height: 80)
                .offset(y: -140)
                .padding()
            
            Rectangle()
                .foregroundStyle(Color("CalendarTwo"))
                .frame(height: 40)
                .offset(y: -95)
                .padding()
            
            VStack {
                Text(monthYearString(from: currentDate))
                    .font(.largeTitle)
                    .padding()
                    .foregroundStyle(.white)
                    .offset(y: 50)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(weekDays, id: \.self) { day in
                        Text(day)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color("TextColor"))
                            .offset(y: 35)
                    }
                }
                .padding()
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(datesInMonth(), id: \.self) { date in
                        ZStack {
                            if let mood = viewModel.moods.first(where: { calendar.isDate($0.timestamp, inSameDayAs: date) }) {
                                Circle()
                                    .foregroundStyle(colorForMood(mood))
                                    .frame(width: 30, height: 30)
                            }
                            
                            Text(dayString(from: date))
                                .foregroundColor(Color("TextColor"))
                        }
                        .frame(width: 40, height: 40)
                    }
                }
                .padding()
                .offset(y: 5)
                
                HStack {
                    Button(action: {
                        currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
                        viewModel.fetchMoods()
                    }) {
                        Image(systemName: "chevron.left")
                            .padding()
                        
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
                        viewModel.fetchMoods()
                    }) {
                        Image(systemName: "chevron.right")
                            .padding()
                    }
                }
                .padding(.horizontal)
                .offset(y: -50)
                .padding()
            }
            .onAppear {
                viewModel.fetchMoods()
            }
            .frame(height: 300)
            .padding()
            .offset(y: 15)
        }
    }
    
    func datesInMonth() -> [Date] {
        var dates: [Date] = []
        
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth) - 1
        
        for _ in 0..<firstWeekday {
            dates.append(Date.distantPast)
        }
        
        for day in range {
            var components = calendar.dateComponents([.year, .month], from: currentDate)
            components.day = day
            if let date = calendar.date(from: components) {
                dates.append(date)
            }
        }
        
        return dates
    }
    
    func dayString(from date: Date) -> String {
        if date == Date.distantPast {
            return ""
        }
        let components = calendar.dateComponents([.day], from: date)
        return String(components.day!)
    }
    
    func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    func colorForMood(_ mood: Mood) -> Color {
        var maxMood = max(mood.happy, max(mood.sad, max(mood.fearful, max(mood.angry, mood.neutral))))
        
        switch maxMood {
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

#Preview {
    MoodCalendarView(viewModel: MoodViewModel())
}
