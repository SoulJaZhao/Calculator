//
//  AppCommand.swift
//  PokeMaster
//
//  Created by Zhao, Long on 2019/12/31.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation

protocol AppCommand {
    func execute(in store: Store)
}


struct LoginAppCommand: AppCommand {
    
    let email: String
    let password: String
    
    func execute(in store: Store) {
        _ = LoginRequest(email: email, password: password).publisher.sink(receiveCompletion: { (complete) in
            if case .failure(let error) = complete {
                store.dispatch(
                    .accountBehaviorDone(result: .failure(error))
                )
            }
        }, receiveValue: { (user) in
            store.dispatch(AppAction.accountBehaviorDone(result: .success(user)))
        })
    }
}
