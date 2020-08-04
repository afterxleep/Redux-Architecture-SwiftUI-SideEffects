//
//  AppStore.swift
//  Redux-Architecture
//
//  Created by Daniel Bernal on 7/30/20.
//

import Foundation
import Combine

typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Never>?
typealias AppStore = Store<AppState, AppAction>

final class Store<State, Action>: ObservableObject {

    // Read only access to app state
    @Published private(set) var state: State
    
    var tasks = [AnyCancellable]()
    
    let serialQueue = DispatchQueue(label: "redux.serial.queue")

    private let reducer: Reducer<State, Action>
    let middlewares: [Middleware<State, Action>]
    private var middlewareCancellables: Set<AnyCancellable> = []

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
        
        // Dispatch all middleware functions        
        for mw in middlewares {
            guard let middleware = mw(state, action) else {
                break
            }
            middleware
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &middlewareCancellables)
        }
    }
}
