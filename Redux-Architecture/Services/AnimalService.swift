//
//  AnimalService.swift
//  Redux-Architecture
//
//  Created by Daniel Bernal on 8/2/20.
//

import Foundation
import Combine

struct AnimalService {

    var requestNumber: Int = 0
    
    func generateAnimalInTheFuture() -> AnyPublisher<String, Never> {
        let animals = ["Cat", "Dog", "Crow", "Horse", "Iguana", "Cow", "Racoon"]
        let number = Double.random(in: 0..<5)
        return Future<String, Never> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + number) {
                let result = animals.randomElement() ?? ""
                print("Animal: \(result)")
                promise(.success(result))
            }
        }
        .eraseToAnyPublisher()
    }
    
}
