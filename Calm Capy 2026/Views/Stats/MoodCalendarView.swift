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
            Spacer()
            
            Rectangle()
                .foregroundStyle(Color("BorderColor"))
                .cornerRadius(10)
                .frame(width: 380, height: 420)
                .offset(y: 25)
            
            Rectangle()
                .foregroundStyle(Color("Default"))
                .cornerRadius(10)
                .frame(height: 410)
                .offset(y: 25)
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
            Spacer()
            
            VStack {
                Spacer()
                Text(monthYearString(from: currentDate))
                    .font(.largeTitle)
                    .padding()
                    .padding(.bottom)
                    .foregroundStyle(.white)
                    .offset(y: 30)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(weekDays, id: \.self) { day in
                        Text(day)
                            .font(.system(size: 18))
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color("TextColor"))
                            .padding(.top)
                            .padding(.bottom)
                    }
                }
                
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
                .frame(width: 350, height: 250)

                .offset(y: 0)
                
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
                .offset(y: -20)
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

#Preview {
    MoodCalendarView(viewModel: MoodViewModel())
}
