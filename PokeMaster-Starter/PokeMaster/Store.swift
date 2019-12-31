//
//  Store.swift
//  PokeMaster
//
//  Created by Zhao, Long on 2019/12/31.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation
import Combine

class Store: ObservableObject {
    @Published var appState = AppState()

    static func reduce(state: AppState, action: AppAction) -> AppState {
        var appState = state
        
        switch action {
        case .login(let email, let password):
            if password == "password" {
                let user = User(email: email, favoritePokemonIDs: [])
                appState.settings.loginUser = user
            }
        }
        return appState
    }
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[ACTION]: \(action)")
        #endif
        let result = Store.reduce(state: appState, action: action)
        appState = result
    }
}
