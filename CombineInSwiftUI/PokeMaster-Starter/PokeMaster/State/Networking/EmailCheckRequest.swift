//
//  EmailCheckRequest.swift
//  PokeMaster
//
//  Created by Zhao, Long on 2020/1/3.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

struct EmailCheckingRequest {
  let email: String

  var publisher: AnyPublisher<Bool, Never> {
    Future<Bool, Never> { promise in
      DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
        if self.email.lowercased() == "onevcat@gmail.com" {
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
