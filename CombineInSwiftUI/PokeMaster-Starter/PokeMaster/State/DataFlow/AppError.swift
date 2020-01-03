//
//  AppError.swift
//  PokeMaster
//
//  Created by 王 巍 on 2019/09/07.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation
import Combine

enum AppError: Error, Identifiable {
    var id: String { localizedDescription }

    case passwordWrong
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .passwordWrong: return "密码错误"
        }
    }
}

class DisposeBag {
    private var values: [AnyCancellable] = []
    func add(_ value: AnyCancellable) {
        values.append(value)
    }
}

extension AnyCancellable {
    func add(to bag: DisposeBag) {
        bag.add(self)
    }
}
