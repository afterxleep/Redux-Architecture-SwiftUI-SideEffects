//
//  AnimalMiddleware.swift
//  Redux-Architecture
//
//  Created by Daniel Bernal on 8/2/20.
//

import Foundation
import Combine

func animalMiddleware(service: AnimalService) -> Middleware<AppState, AppAction> {
    
    return { state, action in
        switch action {
            
            case .animal(.fetchAnimal):
                return service.generateAnimalInTheFuture()
                    .subscribe(on: DispatchQueue.main)
                    .map { AppAction.animal(action: .setCurrentAnimal(animal: $0 )) }
                    .eraseToAnyPublisher()
                
            default:
                break
            }
        
        return Empty().eraseToAnyPublisher()
    }
}
