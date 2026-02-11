//
//  WrView.swift
//  SideProjectTCA
//
//  Created by Pawel Kacela on 10/02/2026.
//

import SwiftUI
import ComposableArchitecture

struct WrView: View {
    
    private let store: StoreOf<WrReducer>
    
    public init(store: StoreOf<WrReducer>) {
        self.store = store
    }
    
    var body: some View {
        LogoView(
            store: store.scope(
                state: \.logo,
                action: \.logo
            )
        )
        Text("Hello")
        Button {
//            store.send(.logo(.didLoad("aaa")))
            
            print("test")
        } label: {
            Text("click here")
        }

    }
    

}
