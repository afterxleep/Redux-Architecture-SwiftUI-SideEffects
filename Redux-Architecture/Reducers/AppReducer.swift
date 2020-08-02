//
//  Reducers.swift
//  Redux-Architecture
//
//  Created by Daniel Bernal on 7/30/20.
//

import Foundation

typealias Reducer<State, Action> = (inout State, Action) -> Void

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch(action) {
    
    case .animal(let action):
        animalReducer(state: &state.animal, action: action)
    }
    
}
