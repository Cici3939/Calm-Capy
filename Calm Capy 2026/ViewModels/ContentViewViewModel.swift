//
//  ContentViewViewModel.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/27/24.
//

import Foundation
import FirebaseAuth

@Observable
class ContentViewViewModel {
    var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in DispatchQueue.main.async {
            self?.currentUserId = user?.uid ?? ""
        }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
