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
        VStack {
            
            ZStack {
                Rectangle()
                    .cornerRadius(10)
                    .foregroundStyle(Color("Default"))
                    .frame(height: 230)
                
                if viewModel.moods.isEmpty {
                    VStack(alignment: .leading) {
                        HStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.yellow)
                                .padding(.trailing)
                            Text("Happy: 0")
                                .foregroundStyle(Color("TextColor"))
                        }
                        
                        HStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.blue)
                                .padding(.trailing)
                            Text("Sad: 0")
                                .foregroundStyle(Color("TextColor"))
                        }
                        
                        HStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.purple)
                                .padding(.trailing)
                            Text("Fearful: 0")
                                .foregroundStyle(Color("TextColor"))
                        }
                        
                        HStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.red)
                                .padding(.trailing)
                            Text("Angry: 0")
                                .foregroundStyle(Color("TextColor"))
                        }

                        HStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.green)
                                .padding(.trailing)
                            Text("Neutral: 0")
                                .foregroundStyle(Color("TextColor"))
                        }

                    }
                }
                else {
                    ForEach(viewModel.moods, id: \.userId) { mood in
                        VStack(alignment: .leading) {
                            HStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.yellow)
                                    .padding(.trailing)
                                Text("Happy: \(mood.happy)")
                                    .foregroundStyle(Color("TextColor"))
                            }
                            
                            HStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.blue)
                                    .padding(.trailing)
                                Text("Sad: \(mood.sad)")
                                    .foregroundStyle(Color("TextColor"))
                            }

                            
                            HStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.purple)
                                    .padding(.trailing)
                                Text("Fearful: \(mood.fearful)")
                                    .foregroundStyle(Color("TextColor"))
                            }

                            
                            HStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.red)
                                    .padding(.trailing)
                                Text("Angry: \(mood.angry)")
                                    .foregroundStyle(Color("TextColor"))
                            }

                            HStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.green)
                                    .padding(.trailing)
                                Text("Neutral: \(mood.neutral)")
                                    .foregroundStyle(Color("TextColor"))
                            }

                        }
                        
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
}

#Preview {
    MoodCountView(viewModel: MoodViewModel())
}
