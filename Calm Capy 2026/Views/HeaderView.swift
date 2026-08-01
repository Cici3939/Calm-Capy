//
//  HeaderView.swift
//  Calm Capy
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let angle: Double
    let background: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(background)
                    .rotationEffect(Angle(degrees: angle))
                
                VStack {
                    Text(title)
                        .font(.system(size: 50))
                        .foregroundStyle(Color.white)
                        .bold()
                    Text(subtitle)
                        .font(.system(size: 23))
                        .foregroundStyle(Color.white)
                }
                .padding(.top, 80)
            }
            .frame(width: geometry.size.width * 3, height: 350)
        }
        .frame(height: 350)
        .offset(y: -200)
    }
}

#Preview {
    HeaderView(title: "Title",
               subtitle: "Subtitle",
               angle: 15,
               background: Color("PrimaryColor"))
}
