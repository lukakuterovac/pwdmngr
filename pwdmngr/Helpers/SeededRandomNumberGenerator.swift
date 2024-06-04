//
//  SeededRandomNumberGenerator.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 03.06.2024..
//

import Foundation

struct SeededRandomNumberGenerator: RandomNumberGenerator {
    private var seed: UInt64
    
    init(seed: UInt64) {
        self.seed = seed
    }
    
    mutating func next() -> UInt64 {
        seed = seed &* 1103515245 &+ 12345
        return seed
    }
}

