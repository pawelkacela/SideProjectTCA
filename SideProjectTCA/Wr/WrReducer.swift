//
//  WrReducer.swift
//  SideProjectTCA
//
//  Created by Pawel Kacela on 10/02/2026.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct WrReducer {
    @ObservableState
    public struct State: Equatable {
        var logo: LogoReducer.State
    }
    
    public enum Action {
        case loadData
        case logo(LogoReducer.Action)
    }
    
    public init() { }
    
//    var body: some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//                case .loadData:
//                return .none
//            case .logo()
//            }
//        }
//    }
}

extension WrReducer.State {
    public init(
        logo: LogoReducer.State = .loading
    ) {
        self.logo = logo
    }
}
