//
//  File.swift
//  TodoList
//
//  Created by Pawel Kacela on 11/02/2026.
//

import Foundation
import SwiftUI
import ComposableArchitecture

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
        .onAppear { store.send(.onAppear) }
    }
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
