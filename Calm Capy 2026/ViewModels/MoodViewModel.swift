//
//  MoodViewModel.swift
//  Calm Capy
//
//  Created by Cici Xing on 8/3/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Mood: Codable {
    var happy: Int
    var sad: Int
    var fearful: Int
    var angry: Int
    var neutral: Int
    var userId: String
    var timestamp: Date
    
    func asDictionary() -> [String: Any] {
        return [
            "happy": happy,
            "sad": sad,
            "fearful": fearful,
            "angry": angry,
            "neutral": neutral,
            "userId": userId,
            "timestamp": timestamp
        ]
    }
}

class MoodViewModel: ObservableObject {
    @Published var moods: [Mood] = []
    
    let timestamp = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date(), matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .backward)!
    
    
    private let db = Firestore.firestore()
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    init() {
        fetchMoods()
    }
    
    func fetchMoods() {
        guard let userId = userId else { return }
        
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
        let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: 0, hour: -1), to: startOfMonth)!
        
        db.collection("moods")
            .whereField("userId", isEqualTo: userId)
            .whereField("timestamp", isGreaterThanOrEqualTo: startOfMonth)
            .whereField("timestamp", isLessThanOrEqualTo: endOfMonth)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error)")
                } else {
                    self?.moods = snapshot?.documents.compactMap {
                        try? $0.data(as: Mood.self)
                    } ?? []
                }
            }
    }
    
    func updateMood(mood: String) {
        guard let userId = userId else { return }

        let startOfDay = Calendar.current.startOfDay(for: Date())

        db.collection("moods")
            .whereField("userId", isEqualTo: userId)
            .whereField("timestamp", isEqualTo: startOfDay)
        
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error)")
                    return
                }

                if let documents = snapshot?.documents, !documents.isEmpty {
                    let document = documents.first!
                    var data = document.data()
                    
                    switch mood {
                    case "Happy":
                        data["happy"] = (data["happy"] as? Int ?? 0) + 1
                    case "Sad":
                        data["sad"] = (data["sad"] as? Int ?? 0) + 1
                    case "Fearful":
                        data["fearful"] = (data["fearful"] as? Int ?? 0) + 1
                    case "Angry":
                        data["angry"] = (data["angry"] as? Int ?? 0) + 1
                    case "Neutral":
                        data["neutral"] = (data["neutral"] as? Int ?? 0) + 1
                    default:
                        break
                    }

                    document.reference.updateData(data) { error in
                        if let error = error {
                            print("Error updating document: \(error)")
                        } else {
                            print("Document updated successfully!")
                            self?.fetchMoods()
                        }
                    }
                } else {
                    let initialMood = Mood(
                        happy: mood == "Happy" ? 1 : 0,
                        sad: mood == "Sad" ? 1 : 0,
                        fearful: mood == "Fearful" ? 1 : 0,
                        angry: mood == "Angry" ? 1 : 0,
                        neutral: mood == "Neutral" ? 1 : 0,
                        userId: userId,
                        timestamp: startOfDay
                    )

                    self?.db.collection("moods").addDocument(data: initialMood.asDictionary()) { error in
                        if let error = error {
                            print("Error creating document: \(error)")
                        } else {
                            print("Document created successfully!")
                            self?.fetchMoods()
                        }
                    }
                }
            }
    }
}

