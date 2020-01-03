//
//  AppState.swift
//  PokeMaster
//
//  Created by Zhao, Long on 2019/12/31.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation

struct AppState {
    var settings = Settings()
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color , favorite
        }
        
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
        
        enum AccountBehavior: CaseIterable {
            case register, login
        }
        
        var accountBehavior = AccountBehavior.login
        var email = ""
        var password = ""
        var verifyPassword = ""
        
        var loginUser: User? =
          // 1
          try? FileHelper.loadJSON(
            from: .documentDirectory,
            fileName: "user.json") {
            didSet {
                if let value = loginUser {
                    // 2
                    try? FileHelper.writeJSON(
                        value,
                        to: .documentDirectory, fileName: "user.json")
                } else {
                    // 3
                    try? FileHelper.delete(
                        from: .documentDirectory,
                        fileName: "user.json")
                }
            }
        }
        var loginRequesting: Bool = false // 正在执行登录请求
        var loginError: AppError?
    }
}

struct User: Codable {
    var email: String
    var favoritePokemonIDs: Set<Int>
    
    func isFavoratePokemon(id: Int)->Bool {
        favoritePokemonIDs.contains(id)
    }
}

