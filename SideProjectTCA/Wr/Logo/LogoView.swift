//
//  LogoView.swift
//  SideProjectTCA
//
//  Created by Pawel Kacela on 10/02/2026.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct LogoView: View {
    
    let store: StoreOf<LogoReducer>
    
    var body: some View {
        Text("Logo")
            .font(.largeTitle)
            .padding()
    }
}
