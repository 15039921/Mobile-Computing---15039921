//
//  GameElements.swift
//  game_Project
//
//  Created by SHIVAM PATEL on (26/12/2018).
//  Copyright © 2019 SHIVAM. All rights reserved.
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
