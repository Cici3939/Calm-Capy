//
//  Chatbot.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/23/24.
//

import Foundation
import SwiftUI
import GoogleGenerativeAI

enum ChatRole {
    case user
    case model
}

struct ChatMessage: Identifiable, Equatable {
    let id = UUID().uuidString
    var role: ChatRole
    var message: String
}

@Observable
class Chatbot {
    private var chat: Chat?
    private(set) var messages = [ChatMessage]()
    private(set) var loadingResponse = false
    
    func sendMessage(_ message: String) {
        loadingResponse = true
        
        var history: [ModelContent] = []
                
        if chat == nil {
            history = messages.map {
                ModelContent(role: $0.role == .user ? "user" : "model", parts: $0.message)
            }
            chat = GenerativeModel(name: "gemini-1.5-flash", apiKey: APIKey.default, systemInstruction: "You are a mental health expert who specializes in mental illnesses Your name is Capy. Talk like a friendly therapist or just a friend and help the user with their mental health if they need it. Don't assume they are struggling immediately").startChat(history: history)
            
        }
        
        messages.append(.init(role: .user, message: message))
        
        Task {
            do {
                let response = try await chat?.sendMessage(message)
                            
                loadingResponse = false
                            
                if let text = response?.text {
                    messages.append(.init(role: .model, message: text))
                } else {
                    messages.append(.init(role: .model, message: "No response from the chatbot."))
                }
            } catch {
                loadingResponse = false
                print("Error while sending message: \(error.localizedDescription)")
                messages.append(.init(role: .model, message: "Something went wrong, please try again."))
            }
        }
    }
}
