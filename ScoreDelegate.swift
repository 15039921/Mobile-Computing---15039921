//
//  ScoreDelegate.swift
//  
//  game_Project
//
//  Created by Shivam  patel on (17/06/2019).
//  Copyright © 2019 Shivam . All rights reserved.
//

import Foundation

protocol ScoreDelegate {
    ///On Score update from GameScene
    func didUpdateScore(score: Int)
    func didHitCrow()
}
