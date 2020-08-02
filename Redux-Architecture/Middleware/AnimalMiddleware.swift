//
//  AnimalMiddleware.swift
//  Redux-Architecture
//
//  Created by Daniel Bernal on 8/2/20.
//

import Foundation
import Combine

func animalMiddleware(service: AnimalService) -> Middleware<AppState, AppAction> {
    
    var cancellables: Set<AnyCancellable> = []
    
    return { state, action, dispatch in
        switch action {
            case .animal(action: .fetchAnimal):
                service.generateAnimalInTheFuture()
                    .sink { dispatch( .animal(action: .setCurrentAnimal(animal: $0))) }
                    .store(in: &cancellables)
            default:
                break
            }
        }
    
}
