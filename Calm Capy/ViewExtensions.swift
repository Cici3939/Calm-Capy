//
//  NavigationTitleColorChanger.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/28/24.
//

import SwiftUI

extension View {
    func navigationTitleColor(_ color: Color) -> some View {
        return self.modifier(NavigationTitleColorModifier(color: color))
    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
            if condition {
                transform(self)
            } else {
                self
            }
        }
}

struct NavigationTitleColorModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .onAppear() {
                let coloredAppearance = UINavigationBarAppearance()
                coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(color)]
                coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(color)]
                UINavigationBar.appearance().standardAppearance = coloredAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            }
    }
}
