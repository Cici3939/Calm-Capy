//
//  User.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/25/24.
//

import Foundation


struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
