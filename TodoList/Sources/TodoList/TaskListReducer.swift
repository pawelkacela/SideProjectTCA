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
        case taskSaved
    }
 
    @Dependency(\.firebaseClient) private var firebase
    
    public var body: some ReducerOf<Self> {
        
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                
                let name = state.taskName
                let date = Date()
                let task = Task(name: name, dateCreated: date)
                state.taskList.append(task)
                state.taskName = ""

                return .run { [name, date, firebase = self.firebase] send in
                    let task = Task(name: name, dateCreated: date)
                    try await firebase.saveTask(task)
                    await send(.taskSaved)
                }
                
            case .taskSaved:
                print("task saved")
                return .none
            case .binding:
                return .none
            }
        }._printChanges()
    }
    
}
