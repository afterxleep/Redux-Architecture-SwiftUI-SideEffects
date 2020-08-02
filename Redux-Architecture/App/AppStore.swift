//
//  AppStore.swift
//  Redux-Architecture
//
//  Created by Daniel Bernal on 7/30/20.
//

import Foundation

typealias Dispatcher<Action> = (Action) -> Void
typealias Middleware<State, Action> = (State, Action, @escaping Dispatcher<Action>) -> Void
typealias AppStore = Store<AppState, AppAction>

final class Store<State, Action>: ObservableObject {

    // Read only access to app state
    @Published private(set) var state: State

    private let reducer: Reducer<State, Action>
    let middlewares: [Middleware<State, Action>]

    init(initialState: State,
         reducer: @escaping Reducer<State, Action>,
         middlewares: [Middleware<State, Action>] = []) {
        self.state = initialState
        self.reducer = reducer
        self.middlewares = middlewares
    }

    // The dispatch function.
    func dispatch(_ action: Action) {
        reducer(&state, action)
        
        middlewares.forEach { middleware in
            middleware(state, action, dispatch)
        }
    }
}
