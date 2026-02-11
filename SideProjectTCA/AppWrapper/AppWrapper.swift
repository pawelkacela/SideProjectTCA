//
//  AppWrapper.swift
//  SideProjectTCA
//
//  Created by Pawel Kacela on 10/02/2026.
//

import SwiftUI
import ComposableArchitecture
import TodoList

@main
public struct AppWrapper: App {
    
    public init() { }
    
//    private let store = Store(
//        initialState: WrReducer.State(),
//        reducer:  { WrReducer() }
//    )
    
    let store = Store(
        initialState: TaskListReducer.State(),
        reducer: {
            TaskListReducer()
        }
    )
    
   public var body: some Scene {
        WindowGroup {
//            WrView(store: store)
            TodoListView(store: store)
        }
    }
}


