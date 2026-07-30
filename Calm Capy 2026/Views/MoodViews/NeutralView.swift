//
//  NeutralView.swift
//  Calm Capy
//

import SwiftUI

struct NeutralView: View {
    var body: some View {
        VStack {
            Text("Neutral")
                .foregroundStyle(Color("TextColor"))
                .font(.system(size: 70))
                .bold()
                .offset(y: 40)
            
            Image("NeutralCapy")
                .resizable()
                .scaledToFit()
            
            Text("It's okay to feel neutral. Capy is here for you!")
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
                            .frame(width: 350, height: 150)
                        VStack{
                            Image("Journal")
                                .resizable()
                                .frame(width: 130, height: 130)
                            
                            Text("Journal Your Thoughts")
                                .foregroundStyle(Color.white)
                                .bold()
                                .offset(y: -10)
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
    NeutralView()
}
