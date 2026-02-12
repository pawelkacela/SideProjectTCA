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
        case eventReceived([Task])
    }
    
    private enum CancelId: Hashable {
      case cancellation
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
                
                return .run { [firebase = self.firebase] send in
                    try await firebase.saveTask(task)
                }
            case .taskFetched(let tasks):
                state.taskList = tasks
                return .none
            case .onAppear:
              return .run { [firebase = self.firebase] send in
                for await event in try await firebase.changesStream() {
                  await send(.eventReceived(event))
                }
              }
              .cancellable(id: CancelId.cancellation)

            case .eventReceived(let event):
              state.taskList = event
              return .none

            case .binding:
                return .none
            }
        }._printChanges()
    }
    
}
