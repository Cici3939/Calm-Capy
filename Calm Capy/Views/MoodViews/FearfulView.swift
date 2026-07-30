//
//  FearfulView.swift
//  Calm Capy
//
//  Created by Cici Xing on 9/28/24.
//

import SwiftUI

struct FearfulView: View {
    var body: some View {
        VStack {
            Text("Fearful")
                .foregroundStyle(Color("TextColor"))
                .font(.system(size: 70))
                .bold()
                .offset(y: 40)
            
            Image("FearfulCapy")
                .resizable()
                .scaledToFit()
            
            Text("Capy is sorry that you are scared.")
                .foregroundStyle(Color("TextColor"))
                .font(.system(size: 20))
            
            Text("You should try:")
                .foregroundStyle(Color("TextColor"))
                .font(.system(size: 20))
            
            HStack {
                NavigationLink(destination: JournalView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color("PrimaryColor"))
                            .frame(width: 110, height: 150)
                        VStack{
                            Image("Journal")
                                .resizable()
                                .frame(width: 100, height: 100)
                            
                            Text("Journal Your \nThoughts")
                                .foregroundStyle(Color.white)
                                .bold()
                                .font(.system(size: 15))
                        }
                    }
                }
                
                NavigationLink(destination: ChatbotView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color("PrimaryColor"))
                            .frame(width: 110, height: 150)
                        
                        VStack{
                            Image("Capybot")
                                .resizable()
                                .frame(width: 100, height: 100)
                            
                            Text("Talk With \nCapybot")
                                .foregroundStyle(Color.white)
                                .bold()
                                .font(.system(size: 15))
                        }
                    }
                }
                
                NavigationLink(destination: BreatheView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color("PrimaryColor"))
                            .frame(width: 110, height: 150)
                        
                        VStack{
                            Image("Breathe with Capy")
                                .resizable()
                                .frame(width: 100, height: 100)
                            
                            Text("Breathe With \nCapy")
                                .foregroundStyle(Color.white)
                                .bold()
                                .font(.system(size: 15))
                        }
                    }
                }
            }
            
            HStack {
                NavigationLink(destination: MainView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color("SecondaryColor"))
                            .frame(width: 350, height: 50)
                        
                        Text("Return Home")
                            .foregroundStyle(Color.white)
                            .bold()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)

        }
        .padding()

    }
}

#Preview {
    FearfulView()
}
