//
//  FirestoreClient.swift
//  TodoList
//
//  Created by Pawel Kacela on 12/02/2026.
//

import Foundation
import FirebaseFirestore

final class FirestoreClient {
 
    static let shared: Self = .init()
    
    private init { }
    
    let dp = Firestore.firestore()
    
    func fetchTask async throws -> [Task] {
        
        let query = try await dp.collection("tasks").getDocuments()
        return try query.documents.compactMap { try $0.data(as: Task.self) }
    }
    
    func saveTask(_ task: Task) async throws {
        try dp.collection("tasks").documents(task.id.uuidString).setData(from: task)
    } 
    
}
