//
//  AppError.swift
//  PokeMaster
//
//  Created by Zhao, Long on 2019/12/31.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation

enum AppError: Error, Identifiable {
    var id: String{ localizedDescription }
    case passwordWrong
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .passwordWrong:
            return "密码错误"
        }
    }
}
