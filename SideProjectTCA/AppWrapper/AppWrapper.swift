//
//  AppWrapper.swift
//  SideProjectTCA
//
//  Created by Pawel Kacela on 10/02/2026.
//

import SwiftUI
import ComposableArchitecture

@main
public struct AppWrapper: App {
    
    public init() { }
    
    private let store = Store(
        initialState: WrReducer.State(),
        reducer:  { WrReducer() }
    )
    
   public var body: some Scene {
        WindowGroup {
            WrView()
        }
    }
}


