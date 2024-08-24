//
//  BreatheView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/28/24.
//

import SwiftUI

struct BreatheView: View {
    @State private var verticalScale: CGFloat = 1.0
    @State private var offsetY: CGFloat = 0
    @State private var isHolding = false
    @State private var isInhaling = false
    @State private var isExhaling = false
    @State private var started = false
    @State private var ended = true

    var body: some View {
        ZStack {
            Rectangle().ignoresSafeArea()
                .foregroundStyle(Color("SecondaryColor"))
            
            VStack {
                if started {
                    Text(textForPhase())
                        .font(.system(size: 50))
                        .foregroundStyle(Color("TextColor"))
                }
                
                ZStack {
                    Image("CapybaraWater")
                        .resizable().frame(width: 400, height: 400)
                    
                    Image("CapybaraBody")
                        .resizable().frame(width: 400, height: 400)
                        .scaleEffect(x: 1.0, y: verticalScale)
                    
                    Image("CapybaraBodyShadow")
                        .resizable().frame(width: 400, height: 400)
                        .offset(y: offsetY)
                    
                    Image("CapybaraNose")
                        .resizable().frame(width: 400, height: 400)
                        .offset(y: offsetY)
                    
                    Image("CapybaraFace")
                        .resizable().frame(width: 400, height: 400)
                        .offset(y: offsetY)
                    
                    Image("CapybaraEars")
                        .resizable().frame(width: 400, height: 400)
                        .offset(y: offsetY)
                    
                    Image("CapybaraLeaf")
                        .resizable().frame(width: 400, height: 400)
                        .offset(x: -5)
                        .offset(y: offsetY)
                }
                .onAppear {
                    if started {
                        animateStretching()
                        animateMoving()
                    }
                }
                
                CCButton(title: "Start Breathing with Capy",
                         background: Color("PrimaryColor")) {
                    ended = false
                    started = true
                    animateStretching()
                    animateMoving()
                }
                         .frame(width: 300, height: 50)
                         .padding()
                
                CCButton(title: "Stop Breathing with Capy",
                         background: Color("PrimaryColor")) {
                    started = false
                    ended = true
                    verticalScale = 1.0
                    offsetY = 0

                    isHolding = false
                    isInhaling = false
                    isExhaling = false
                }
                         .frame(width: 300, height: 50)
                         .padding(.leading)
                         .padding(.trailing)
                         .padding(.bottom)
            }
        }
    }
    
    private func textForPhase() -> String {
        if isInhaling {
            return "In"
        } else if isHolding {
            return "Hold"
        } else if isExhaling {
            return "Out"
        } else {
            return ""
        }
    }
    
    private func animateStretching() {
        guard started else { return }
        
        isExhaling = false
        isInhaling = true
        
        withAnimation(Animation.easeInOut(duration: 4)) {
            verticalScale = 1.2
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            if started {
                isInhaling = false
                isHolding = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    if started {
                        isHolding = false
                        isExhaling = true
                        withAnimation(Animation.easeInOut(duration: 8)) {
                            verticalScale = 1.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                            if started {
                                animateStretching()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func animateMoving() {
        guard started else { return }
        
        withAnimation(Animation.easeInOut(duration: 4)) {
            offsetY = -30
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            if started {
                isHolding = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    if started {
                        withAnimation(Animation.easeInOut(duration: 8)) {
                            offsetY = 0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                            if started {
                                animateMoving()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BreatheView()
}
