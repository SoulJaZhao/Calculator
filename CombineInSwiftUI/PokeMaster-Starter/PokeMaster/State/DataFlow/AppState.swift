//
//  AppState.swift
//  PokeMaster
//
//  Created by Wang Wei on 2019/09/04.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Combine
import Foundation

struct AppState {
    var settings = Settings()
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }

        enum AccountBehavior: CaseIterable {
            case register, login
        }
        
        var isEmailValid: Bool = false

//        var accountBehavior = AccountBehavior.login
//        var email = ""
//        var password = ""
//        var verifyPassword = ""
        class AccountChecker {
            @Published var accountBehavior = AccountBehavior.login
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            // check email is valid
            var isEmailValid: AnyPublisher<Bool, Never> {
                let remoteVerify = $email
                    .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                    .removeDuplicates()
                    .flatMap { (email) -> AnyPublisher<Bool, Never> in
                        let validEmail = email.isValidEmailAddress
                        let canSkip = self.accountBehavior == .login
                        
                        switch (validEmail, canSkip) {
                        case (false, _):
                            return Just(false).eraseToAnyPublisher()
                        case (true, false):
                            return EmailCheckingRequest.init(email: email)
                                .publisher
                                .eraseToAnyPublisher()
                        case (true, true):
                            return Just(true).eraseToAnyPublisher()
                        }
                }
                
                let emailLocalValid = $email.map {
                    $0.isValidEmailAddress
                }
                
                let canSkipRemoteVerify = $accountBehavior.map {
                    $0 == .login
                }
                
                return Publishers.CombineLatest3(remoteVerify, emailLocalValid, canSkipRemoteVerify).map {
                    $0 && ($1 || $2)
                }.eraseToAnyPublisher()
            }
        }
        
        // Mock email check request
        struct EmailCheckingRequest {
            let email: String
            
            var publisher: AnyPublisher<Bool, Never> {
                Future<Bool, Never>{ (promise) in
                    DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                        if self.email.lowercased() == "onecat@gmail.com" {
                            promise(.success(false))
                        } else {
                            promise(.success(true))
                        }
                    }
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
            }
        }
        
        // Add checker object
        var checker = AccountChecker()
        
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false

        @FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?

        var loginRequesting = false
        var loginError: AppError?
    }
}
