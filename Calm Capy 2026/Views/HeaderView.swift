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
                Rectangle()
                    .foregroundStyle(background)
                    .frame(width: geometry.size.width * 2, height: geometry.size.height)
                    .rotationEffect(.degrees(angle))

                VStack(spacing: 8) {
                    Text(title)
                        .font(.system(size: 80))
                        .foregroundStyle(.white)
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: .infinity)

                    Text(subtitle)
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .frame(maxWidth: .infinity)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, geometry.size.width * 0.25)
                .padding(.top, geometry.size.height * 0.5)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            }
            .offset(x: geometry.size.width * -0.5)
        }
    }
}

#Preview {
    HeaderView(title: "Title",
               subtitle: "Subtitle",
               angle: 15,
               background: Color("PrimaryColor"))
}
