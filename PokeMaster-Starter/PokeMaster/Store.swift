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

    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand?
        
        switch action {
        case .login(let email, let password):
            // 1
            guard !appState.settings.loginRequesting else {
                break
            }
            appState.settings.loginRequesting = true
            // 2
            appCommand = LoginAppCommand(email: email, password: password)
            break
        case .accountBehaviorDone(let result):
            // 1
            appState.settings.loginRequesting = false
            switch result {
            case .success(let user):
                // 2
                appState.settings.loginUser = user
            case .failure(let error):
                // 3
                print("Error:\(error)")
                appState.settings.loginError = error
            }
        }
        return (appState, appCommand)
    }
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[ACTION]: \(action)")
        #endif
        let result = Store.reduce(state: appState, action: action)
        // 1
        appState = result.0
        // 2
        if let command = result.1 {
            #if DEBUG
            print("[COMMAND]:\(command)")
            #endif
            command.execute(in: self)
        }
    }
}
