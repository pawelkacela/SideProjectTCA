//
//  LogoReducer.swift
//  SideProjectTCA
//
//  Created by Pawel Kacela on 10/02/2026.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct LogoReducer {
    @ObservableState
    public enum State: Equatable {
        case loading
        case content(String)
    }
}
