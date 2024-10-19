//
//  HappyView.swift
//  Calm Capy
//
//  Created by Cici Xing on 9/28/24.
//

import SwiftUI

struct HappyView: View {
    var body: some View {
        VStack {
            Text("Happy")
                .foregroundStyle(Color("TextColor"))
                .font(.system(size: 70))
                .bold()
                .offset(y: 40)
            
            Image("HappyCapy")
                .resizable()
                .scaledToFit()
            
            Text("Capy is glad that you are happy!")
                .foregroundStyle(Color("TextColor"))
                .font(.system(size: 20))
            
            Text("You can:")
                .foregroundStyle(Color("TextColor"))
                .font(.system(size: 20))
            
            HStack {
                NavigationLink(destination: JournalView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color("PrimaryColor"))
                            .frame(width: 170, height: 150)
                        VStack{
                            Image("Journal")
                                .resizable()
                                .frame(width: 100, height: 100)
                            
                            Text("Journal Your Thoughts")
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
                            .frame(width: 170, height: 150)
                        
                        VStack{
                            Image("Capybot")
                                .resizable()
                                .frame(width: 100, height: 100)
                            
                            Text("Share With Capybot")
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
    HappyView()
}
