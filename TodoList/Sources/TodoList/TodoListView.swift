//
//  File.swift
//  TodoList
//
//  Created by Pawel Kacela on 11/02/2026.
//

import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
public struct TaskListReducer {
    
    public init() { }
    
    @ObservableState
    public struct State: Equatable {
        var taskName: String
        var taskList: [Task]
        
        public init(taskName: String = "", taskList: [Task] = []) {
            self.taskName = taskName
            self.taskList = taskList
        }
    }
    
   public enum Action {
        case addButtonTapped
    }
    
    public var body: some ReducerOf<Self> {

        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                
                let task = Task(name: "test", dateCreated: Date())
                state.taskList.append(task)
                return .none
            }
        }._printChanges()
    }
    
}

public struct TodoListView: View {
    
    private let store: StoreOf<TaskListReducer>
    
    public init(store: StoreOf<TaskListReducer>) {
        self.store = store
    }

    public var body: some View {
        
        List {
            ForEach(store.taskList) { task in
                HStack {
                    Text(task.name)
                    Text(task.dateCreated.description)
                }
            }
        }
        Spacer()
        Button {
            store.send(.addButtonTapped)
        } label: {
            Text("dodaj")
                .foregroundStyle(.white)
                .padding(10)
                .background(.gray)
        }
        .padding()
    }
}
 
public struct Task: Identifiable, Equatable {
    public var id: UUID = .init()
    public var name: String
    public var dateCreated: Date
}


#Preview {
    let store = Store(
        initialState: TaskListReducer.State(),
        reducer: {
            TaskListReducer()
        }
    )
    
    TodoListView(store: store)
}
