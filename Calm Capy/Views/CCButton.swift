//
//  CCButton.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/25/24.
//

import SwiftUI

struct CCButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(background)
                
                Text(title)
                    .foregroundStyle(Color("Default"))
                    .bold()
            }
        }

    }
}

#Preview {
    CCButton(title: "Value",
             background: Color("PrimaryColor")) {
    }
}
