//
//  AppWrapper.swift
//  SideProjectTCA
//
//  Created by Pawel Kacela on 10/02/2026.
//

import SwiftUI
import ComposableArchitecture
import TodoList
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
public struct AppWrapper: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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


