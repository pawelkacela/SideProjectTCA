@preconcurrency import FirebaseFirestore
import Dependencies


struct FirebaseClient {
    var fetchTask: @Sendable () async throws -> [Task]
    var saveTask: @Sendable (Task) async throws -> Void
    var changesStream: @Sendable () async throws -> AsyncStream<[Task]>
}

extension FirebaseClient: DependencyKey {
    
    static var liveValue: Self {
        let db = Firestore.firestore()
        return FirebaseClient(
            
            fetchTask: {
                let query = try await db.collection("tasks").getDocuments()
                return try query.documents.compactMap {
                    try $0.data(as: Task.self)
                }
            }, saveTask: { task in
                try db.collection("tasks").document(task.id.uuidString).setData(from: task)
            },
            changesStream: {
              return AsyncStream { continuation in
                let listener = db.collection("tasks").addSnapshotListener { snapshot, error in
                  guard let snapshot
                  else { return }

                  let tasks = try? snapshot.documents.compactMap { try $0.data(as: Task.self) }
                  continuation.yield(tasks ?? [])
                }

                continuation.onTermination = { @Sendable _ in
                  listener.remove()
                }
              }
            }
            
        )
        
    }
}

extension DependencyValues {
  var firebaseClient: FirebaseClient {
    get { self[FirebaseClient.self] }
    set { self[FirebaseClient.self] = newValue }
  }
}
