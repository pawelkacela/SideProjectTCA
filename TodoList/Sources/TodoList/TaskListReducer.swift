//
//  TaskListReducer.swift
//  TodoList
//
//  Created by Pawel Kacela on 11/02/2026.
//

import Foundation
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
    
    public enum Action: BindableAction {
        case addButtonTapped
        case binding(BindingAction<State>)
        case taskFetched([Task])
        case onAppear
    }
 
    @Dependency(\.firebaseClient) private var firebase
    
    public var body: some ReducerOf<Self> {
        
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                
                let task = Task(name: state.taskName, dateCreated: Date())
                state.taskList.append(task)
                state.taskName = ""
                
                return .concatenate(
                    .run { [firebase = self.firebase] send in
                        try await firebase.saveTask(task)
                    },
                    .run { [firebase = self.firebase] send in
                        let tasks = try await firebase.fetchTask()
                        await send(.taskFetched(tasks))
                    }
                )
            case .taskFetched(let tasks):
                state.taskList = tasks
                return .none
            case .onAppear:
                return .run { [firebase = self.firebase] send in
                    let tasks = try await firebase.fetchTask()
                    await send(.taskFetched(tasks))
                }
            case .binding:
                return .none
            }
        }._printChanges()
    }
    
}
