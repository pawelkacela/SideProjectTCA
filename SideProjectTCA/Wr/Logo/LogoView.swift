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
        content
            .font(.largeTitle)
            .padding()
    }
}


private extension LogoView {
    var content: some View {
        
        VStack(alignment: .leading) {
            switch store.state {
            case .loading:
                progressView
            case let .content(title):
                Text(title)
            }
        }
            
    }
    
    var progressView: some View {
        HStack {
            Spacer()
            ProgressView()
                .tint(.red)
            Spacer()
        }
    }
}


