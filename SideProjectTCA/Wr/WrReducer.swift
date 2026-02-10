//
//  WrReducer.swift
//  SideProjectTCA
//
//  Created by Pawel Kacela on 10/02/2026.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct WrReducer: Reducer {
    @ObservableState
    public struct State: Equatable {
        var logo: LogoReducer.State
    }
    
    public enum Action {
        case loadData
    }
    
    public init() { }
}

extension WrReducer.State {
    public init(
        logo: LogoReducer.State = .loading
    ) {
        self.logo = logo
    }
}
