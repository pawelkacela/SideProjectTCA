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
    
    public enum Action: BindableAction {
        case addButtonTapped
        case binding(BindingAction<State>)
    }
    
    public var body: some ReducerOf<Self> {
        
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                
                let task = Task(name: state.taskName, dateCreated: Date())
                state.taskList.append(task)
                state.taskName = ""
                return .none
            case .binding:
                return .none
            }
        }._printChanges()
    }
    
}

public struct TodoListView: View {
    
    @Bindable private var store: StoreOf<TaskListReducer>
    
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
        TextField("", text: $store.taskName)
            .padding(10)
            .background(.gray.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            .padding([.leading, .trailing], 32)
        
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
