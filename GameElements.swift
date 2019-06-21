//
//  GameElements.swift
//  
//  game_Project
//
//  Created by Shivam  patel on (17/06/2019).
//  Copyright © 2019 Shivam . All rights reserved.
//
import SpriteKit

struct CollisionBitMask {
    static let carCategory:UInt32 = 0x1 << 0
    static let roadCategory:UInt32 = 0x1 << 1
    static let treesCategory:UInt32 = 0x1 << 2
    static let cloudsCategory:UInt32 = 0x1 << 3
}

extension GameScene {
}
