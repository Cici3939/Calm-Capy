//
//  ChatbotView.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/23/24.
//

import SwiftUI

struct ChatbotView: View {
    @State var textInput = ""
    @State var logoAnimating = false
    @State var timer: Timer?
    @State var chatBot = Chatbot()
    
    var body: some View {
        NavigationStack {
            Text("")
                .navigationTitle("Calm Capy Chatbot")
                .navigationTitleColor(Color("TextColor"))
            
            // MARK: Chat message list
            ScrollViewReader(content: { proxy in
                ScrollView {
                    ForEach(chatBot.messages) { chatMessage in
                        // MARK: Chat message view
                        chatMessageView(chatMessage)
                    }
                }
                .onChange(of: chatBot.messages) { _, _ in
                    guard let recentMessage = chatBot.messages.last else { return }
                    DispatchQueue.main.async {
                        withAnimation {
                            proxy.scrollTo(recentMessage.id, anchor: .bottom)
                        }
                    }
                }
                .onChange(of: chatBot.loadingResponse) { _, newValue in
                    if newValue {
                        startLoadingAnimation()
                    } else {
                        stopLoadingAnimation()
                    }
                }
                
                Button("", systemImage: "arrowshape.down.circle") {
                    guard let recentMessage = chatBot.messages.last else { return }
                    proxy.scrollTo(recentMessage.id, anchor: .bottom)
                }
                .frame(width: 30, height: 30, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 350, bottom: 0, trailing: 10))
                .font(.system(size: 25))
                
            })
            
            HStack(alignment: .bottom) {
                TextField("Type something", text: $textInput, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(30)
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 10, trailing: 0))
                
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                    }
                    .foregroundStyle(Color("Default"))
                    .font(.system(size: 25))
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 15))
                    
            }
            .background() {
                Color("PrimaryColor")
            }
            
            Spacer()
            
        }
        .foregroundStyle(Color("PrimaryColor"))
        .background {
            ZStack {
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder func chatMessageView(_ message: ChatMessage) -> some View {
        ChatBubble(direction: message.role == .model ? .left : .right) {
            Text(message.message)
                .font(.title3)
                .padding(.all, 20)
                .foregroundStyle(.white)
                .background(message.role == .model ? Color("ChatBubbleBotColor") : Color("ChatBubbleUserColor"))
        }
    }
    
    func sendMessage() {
        if textInput != "" {
            chatBot.sendMessage(textInput)
            textInput = ""
        }
    }
    func startLoadingAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
            logoAnimating.toggle()
        })
    }
    
    func stopLoadingAnimation() {
        logoAnimating = false
        timer?.invalidate()
        timer = nil
    }
    
    
}

#Preview {
    ChatbotView()
}
