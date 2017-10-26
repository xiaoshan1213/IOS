//
//  main.swift
//  Project and Class
//
//  Created by Sam Ma on 10/25/17.
//  Copyright © 2017 Sam Ma. All rights reserved.
//

import Foundation

print("Hello, World!")


class Car {
    
    enum CarType {
        case sendan
        case volve
    }
    
    var Cartype : CarType = .sendan
    // optional ? only when it get called, the value reveals
    var carOwner : String?
    
    init() {
        
    }
    
    init(carOwner : String) {
        self.carOwner = carOwner
    }
    
    func drive() {
//        optional binding
        if let tempCarOwner = carOwner {
            // force unwrapping
            print(carOwner!)
        }
        if carOwner != nil {
            print(carOwner!)
        }
    }
}

