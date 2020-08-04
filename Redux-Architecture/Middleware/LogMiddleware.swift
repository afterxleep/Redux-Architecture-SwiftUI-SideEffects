//
//  LogMiddleware.swift
//  Redux-Architecture
//
//  Created by Daniel Bernal on 8/2/20.
//

import Foundation
import Combine

func logMiddleware() -> Middleware<AppState, AppAction> {

    return { state, action in
        print("Triggered action: \(action)")
        return Empty().eraseToAnyPublisher()
    }
 
    
}
