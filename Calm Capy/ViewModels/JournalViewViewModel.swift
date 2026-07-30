//
//  JournalViewViewModel.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/30/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct JournalEntry: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var content: String
    var date: Date
    var userId: String

    func asDictionary() -> [String: Any] {
        return [
            "id": id,
            "title": title,
            "content": content,
            "date": Timestamp(date: date),
            "userId": userId
        ]
    }
}


class JournalViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = []
    
    private let db = Firestore.firestore()
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    init() {
        fetchEntries()
    }
    
    func fetchEntries() {
        guard let userId = userId else { return }
        
        db.collection("journalEntries")
            .whereField("userId", isEqualTo: userId)
            .order(by: "date", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error)")
                } else {
                    self?.entries = snapshot?.documents.compactMap {
                        try? $0.data(as: JournalEntry.self)
                    } ?? []
                }
            }
    }
    
    func addNewEntry(title: String, content: String, date: Date) {
        guard let userId = userId else { return }
        
        let newEntry: [String: Any] = [
            "title": title,
            "content": content,
            "date": date,
            "userId": userId
        ]
        
        db.collection("journalEntries").addDocument(data: newEntry) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully!")
            }
        }
    }
    
    func updateEntry(entry: JournalEntry) {
        guard let entryId = entry.id else { return }
        
        let db = Firestore.firestore()
        db.collection("journalEntries").document(entryId).setData(entry.asDictionary()) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document updated successfully!")
            }
        }
    }
    
    func deleteEntry(entryId: String) {
        guard let userId = userId else { return }
        
        db.collection("journalEntries").document(entryId).delete { [weak self] error in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                print("Document deleted successfully!")
                if let index = self?.entries.firstIndex(where: { $0.id == entryId }) {
                    self?.entries.remove(at: index)
                }
            }
        }
    }
}
