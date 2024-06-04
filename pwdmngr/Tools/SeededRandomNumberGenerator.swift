//
//  SeededRandomNumberGenerator.swift
//  pwdmngr
//
//  Created by Luka Kuterovac on 03.06.2024..
//

import Foundation

struct SeededRandomNumberGenerator: RandomNumberGenerator {
    var seed: UInt64
    
    mutating func next() -> UInt64 {
        seed = seed &* 6364136223846793005 &+ 1
        return seed
    }
}
