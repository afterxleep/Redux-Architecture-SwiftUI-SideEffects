//
//  LogMiddleware.swift
//  Redux-Architecture-Part1
//
//  Created by Daniel Bernal on 8/2/20.
//

import Foundation

func logMiddleware() -> Middleware<AppState, AppAction> {
    
    return { state, action, dispatch in
        print("Triggered action: \(action)")
    }
    
}
