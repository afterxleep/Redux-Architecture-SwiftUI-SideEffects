//
//  ContentView.swift
//  Redux-Architecture
//
//  Created by Daniel Bernal on 7/30/20.
//

import SwiftUI

struct ContentView: View {
    let store = AppStore(initialState: .init(
                            animal: AnimalState()
                        ),
                      reducer: appReducer,
                      middlewares: [
                        animalMiddleware(service: AnimalService()),
                        logMiddleware()
                      ])
    
    init() {
        store.dispatch(.animal(action: .fetchAnimal))
    }
    
    var body: some View {
        AnimalView()
            .environmentObject(store)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
