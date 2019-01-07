//
//  GameScene.swift
//  game_Project
//
//  Created by SHIVAM PATEL on (26/12/2018).
//  Copyright © 2019 SHIVAM. All rights reserved.
//

import SpriteKit
import GameplayKit

struct ColliderType{
    static let Player: UInt32 = 1
    static let Enemy: UInt32 = 1
    static let Bird: UInt32 = 1

}

class GameScene: SKScene, SKPhysicsContactDelegate {
    // every skspritenode == one object in game like coin, car, bird
    
    var score = 0
    var car = SKSpriteNode()
    var textureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    var bird = [SKSpriteNode]()
    var textureAtlas_bird = SKTextureAtlas()
    var TextureArray_bird = [SKTexture]()
    var coin = [SKSpriteNode]()

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(size: CGSize) {
        super.init(size: size)


    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // first = physicalbody of player/car which is named as player (car.name = player)
        var first = SKPhysicsBody()
        // second = physicalbody of coins which is named as enemy (coins.name = enemy)

        var second = SKPhysicsBody()
        
        
        if contact.bodyA.node?.name == "player"{
            first = contact.bodyA
            second = contact.bodyB
        }
        else{
            first = contact.bodyB
            second = contact.bodyA
        
        }
        // if car collide with coins than remove coins
        
        if first.node?.name == "player" && second.node?.name == "Enemy"{
            
            score = score + 350
            print("contact\(score)")
            second.node?.removeFromParent()

        }
        // if car collide with birds than birds start falling

        
        if first.node?.name == "player" && second.node?.name == "bird"{
            
            print("bird")
            second.node?.physicsBody?.affectedByGravity = true
            
        }
    }


    override func didMove(to view: SKView) {
        // must use delegate to use functions of physical bodies
       physicsWorld.contactDelegate = self
        
        
      // createBackground() is the function to animate background like clouds, trees and roads we add all this stuff in one image which is in assets with the name of bg
        createBackground()
        
        // animate car = animate player.. plane.atlas is used

        animate_car()
        
        // animated bird .. bird.atlas is used... atlas is used for images file to store and give texture... bird is animating from right to left
        
        animate_bird()
        
        // animate coins from right to left and stick coins on multiple locations of screen or background
        
        coins()

    }
   
    
    func createBackground() {
        let backgroundTexture = SKTexture(imageNamed: "bg")
        
        for i in 0 ... 1{
            let background = SKSpriteNode(texture: backgroundTexture)
            background.zPosition = -30
            background.size = frame.size
            background.anchorPoint = CGPoint.zero
//                    background.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)

            background.position = CGPoint(x: (frame.size.width * CGFloat(i)) - CGFloat(1 * i), y: 0)
            addChild(background)
            let moveLeft = SKAction.moveBy(x: -frame.size.width, y: 0, duration: 05)
            let moveReset = SKAction.moveBy(x: frame.size.width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            
            background.run(moveForever)
        }
    }
    func animate_car(){
        textureAtlas = SKTextureAtlas(named: "plane")
        for i in 0 ... textureAtlas.textureNames.count{
            let name = "plane\(i+1)"
            TextureArray.append(SKTexture(imageNamed: name))
        }
        car = SKSpriteNode(imageNamed: "plane1")
        car.position = CGPoint(x: 100, y:car.size.height+100)
        car.run(SKAction.repeatForever(
            SKAction.animate(with: TextureArray,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                withKey:"walkingInPlaceBear")
        car.name = "player"
        
        car.physicsBody = SKPhysicsBody(texture: car.texture!,
                                        size: car.texture!.size())
        car.physicsBody?.affectedByGravity = false

        car.physicsBody!.isDynamic = false
        
        car.physicsBody!.categoryBitMask = ColliderType.Player
        car.physicsBody!.collisionBitMask = ColliderType.Enemy
        car.physicsBody!.contactTestBitMask = ColliderType.Enemy

        self.addChild(car)


    }
    func coins(){
        //  you can reset location of coins by updating { coin[i].position = CGPoint(x: 80 * i+Int(0.5), y:130)}

//
        let moveLeft = SKAction.moveBy(x: -frame.size.width, y: 0, duration: 30)
        let moveReset = SKAction.moveBy(x: frame.size.width, y: 0, duration: 0)
        let moveLoop = SKAction.sequence([moveLeft,moveReset])
        let moveForever = SKAction.repeatForever(moveLoop)

            for i in 0 ... 15{
                
                
                if(i<3){
                    coin.append(SKSpriteNode(imageNamed: "coin"))
                    coin[i].size = CGSize(width: 30, height: 30)
                    coin[i].position = CGPoint(x: 80 * i+Int(0.5), y:130)
                    coin[i].name = "Enemy"
                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
                    coin[i].physicsBody?.affectedByGravity = false
                    coin[i].physicsBody?.isDynamic = true
                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
                    self.addChild(coin[i])
                    coin[i].run(moveForever)
                    
                }
                else{
                    if(i<8){
                    coin.append(SKSpriteNode(imageNamed: "coin"))
                    coin[i].size = CGSize(width: 30, height: 30)
                    coin[i].position = CGPoint(x: 40 * i+Int(0.5), y:150)
                    coin[i].name = "Enemy"
                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
                    coin[i].physicsBody?.affectedByGravity = false
                    coin[i].physicsBody?.isDynamic = true
                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
                    self.addChild(coin[i])
                    coin[i].run(moveForever)
                    }
                    else{
                        if(i<15){
                            coin.append(SKSpriteNode(imageNamed: "coin"))
                            coin[i].size = CGSize(width: 30, height: 30)
                            coin[i].position = CGPoint(x: 50 * i-2, y:250)
                            coin[i].name = "Enemy"
                            coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
                            coin[i].physicsBody?.affectedByGravity = false
                            coin[i].physicsBody?.isDynamic = true
                            coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
                            self.addChild(coin[i])
                            coin[i].run(moveForever)
                        }
                    }
                }
                    
                
//                }
//                if(i == 1){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 1.5, y:150 * 1.5)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//
//                }
//                if(i == 2){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 3, y:150 * 2)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
//                if(i == 3){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 2.5, y:150 * 2.2)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
//                if(i == 4){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 2, y:150 * 1.5)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
//                if(i == 5){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 7, y:150 * 1)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//
//                }
//                if(i == 6){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 5, y:150 * 1.5)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//
//                }
//                if(i == 7){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 4, y:150 * 2)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
//                if(i == 8){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 5, y:150 * 2.2)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
//                if(i == 9){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 6, y:150 * 1.5)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
//                if(i == 10){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 7, y:150 * 1.5)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//
//                }
//                if(i == 11){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 9, y:150 * 2)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
//                if(i == 12){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 8, y:150 * 2.2)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
//                if(i == 13){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 7, y:150 * 2.5)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
//                if(i == 14){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 13, y:150 * 2)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
//                if(i == 15){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 11, y:150 * 2)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
//                if(i == 16){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 12, y:150 * 2.5)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
//                if(i == 17){
//                    coin.append(SKSpriteNode(imageNamed: "coin"))
//                    coin[i].size = CGSize(width: 30, height: 30)
//                    coin[i].position = CGPoint(x: 100 * 13, y:150 * 2)
//                    coin[i].name = "Enemy"
//                    coin[i].physicsBody = SKPhysicsBody(circleOfRadius: coin[i].size.width/2)
//                    coin[i].physicsBody?.affectedByGravity = false
//                    coin[i].physicsBody?.isDynamic = true
//                    coin[i].physicsBody?.categoryBitMask = ColliderType.Enemy
//                    self.addChild(coin[i])
//                    coin[i].run(moveForever)
//
//
//                }
            }
       
            
        
        
        
    }
    func animate_bird(){
        //  you can reset location of birds by updating { coin[i].position = CGPoint(x: 80 * i+Int(0.5), y:130)}

        textureAtlas_bird = SKTextureAtlas(named: "bird")
        for i in 1 ... textureAtlas_bird.textureNames.count{
            let name_bird = "bird\(i)"
            TextureArray_bird.append(SKTexture(imageNamed: name_bird))
        }
        let moveLeft = SKAction.moveBy(x: -frame.size.width, y: 0, duration: 30)
        let moveReset = SKAction.moveBy(x: frame.size.width, y: 0, duration: 0)
        let moveLoop = SKAction.sequence([moveLeft,moveReset])
        let moveForever = SKAction.repeatForever(moveLoop)
      
        for i in 0 ... 10{
//            if(i == 0){
                bird.append(SKSpriteNode(imageNamed: "bird1"))
                bird[i].size = CGSize(width: 50, height: 50)
                bird[i].position = CGPoint(x: 75 * i*2, y:40 * i+1)
                bird[i].name = "bird"
                bird[i].physicsBody = SKPhysicsBody(texture: bird[i].texture!,
                                                    size: bird[i].size)
                bird[i].physicsBody?.affectedByGravity = false
                bird[i].physicsBody?.isDynamic = true
                bird[i].physicsBody?.categoryBitMask = ColliderType.Bird
                self.addChild(bird[i])
             
                
                bird[i].run(moveForever)
                bird[i].run(SKAction.repeatForever(
            SKAction.animate(with: TextureArray_bird, timePerFrame: 0.1)))
//            }
//            if(i == 1){
//                bird.append(SKSpriteNode(imageNamed: "bird1"))
//                bird[i].size = CGSize(width: 50, height: 50)
//                bird[i].position = CGPoint(x: 100 * 9, y:150 * 2)
//                bird[i].name = "bird"
//                bird[i].physicsBody = SKPhysicsBody(texture: bird[i].texture!,
//                                                    size: bird[i].size)
//                bird[i].physicsBody?.affectedByGravity = false
//                bird[i].physicsBody?.isDynamic = true
//                bird[i].physicsBody?.categoryBitMask = ColliderType.Bird
//                self.addChild(bird[i])
//                bird[i].run(moveForever)
//
//                bird[i].run(SKAction.repeatForever(
//                    SKAction.animate(with: TextureArray_bird, timePerFrame: 0.1)))
//            }
//            if(i == 2){
//                bird.append(SKSpriteNode(imageNamed: "bird1"))
//                bird[i].size = CGSize(width: 50, height: 50)
//                bird[i].position = CGPoint(x: 100 * 5, y:150 * 2)
//                bird[i].name = "bird"
//                bird[i].physicsBody = SKPhysicsBody(texture: bird[i].texture!,
//                                                    size: bird[i].size)
//                bird[i].physicsBody?.affectedByGravity = false
//                bird[i].physicsBody?.isDynamic = true
//                bird[i].physicsBody?.categoryBitMask = ColliderType.Bird
//                self.addChild(bird[i])
//                bird[i].run(moveForever)
//
//                bird[i].run(SKAction.repeatForever(
//                    SKAction.animate(with: TextureArray_bird, timePerFrame: 0.1)))
//            }
//            if(i == 3){
//                bird.append(SKSpriteNode(imageNamed: "bird1"))
//                bird[i].size = CGSize(width: 50, height: 50)
//                bird[i].position = CGPoint(x: 100 * 4, y:150 * 0.5)
//                bird[i].name = "bird"
//                bird[i].physicsBody = SKPhysicsBody(texture: bird[i].texture!,
//                                                    size: bird[i].size)
//                bird[i].physicsBody?.affectedByGravity = false
//                bird[i].physicsBody?.isDynamic = true
//                bird[i].physicsBody?.categoryBitMask = ColliderType.Bird
//                self.addChild(bird[i])
//                bird[i].run(moveForever)
//
//                bird[i].run(SKAction.repeatForever(
//                    SKAction.animate(with: TextureArray_bird, timePerFrame: 0.1)))
//            }
//            if(i == 4){
//                bird.append(SKSpriteNode(imageNamed: "bird1"))
//                bird[i].size = CGSize(width: 50, height: 50)
//                bird[i].position = CGPoint(x: 100 * 7, y:150 * 2)
//                bird[i].name = "bird"
//                bird[i].physicsBody = SKPhysicsBody(texture: bird[i].texture!,
//                                                    size: bird[i].size)
//                bird[i].physicsBody?.affectedByGravity = false
//                bird[i].physicsBody?.isDynamic = true
//                bird[i].physicsBody?.categoryBitMask = ColliderType.Bird
//                self.addChild(bird[i])
//                bird[i].run(moveForever)
//
//                bird[i].run(SKAction.repeatForever(
//                    SKAction.animate(with: TextureArray_bird, timePerFrame: 0.1)))
//            }
//            if(i == 5){
//                bird.append(SKSpriteNode(imageNamed: "bird1"))
//                bird[i].size = CGSize(width: 50, height: 50)
//                bird[i].position = CGPoint(x: 100 * 8, y:150 * 2)
//                bird[i].name = "bird"
//                bird[i].physicsBody = SKPhysicsBody(texture: bird[i].texture!,
//                                                    size: bird[i].size)
//                bird[i].physicsBody?.affectedByGravity = false
//                bird[i].physicsBody?.isDynamic = true
//                bird[i].physicsBody?.categoryBitMask = ColliderType.Bird
//                self.addChild(bird[i])
//                bird[i].run(moveForever)
//
//                bird[i].run(SKAction.repeatForever(
//                    SKAction.animate(with: TextureArray_bird, timePerFrame: 0.1)))
//            }
//            if(i == 6){
//                bird.append(SKSpriteNode(imageNamed: "bird1"))
//                bird[i].size = CGSize(width: 50, height: 50)
//                bird[i].position = CGPoint(x: 100 * 7, y:150 * 3)
//                bird[i].name = "bird"
//                bird[i].physicsBody = SKPhysicsBody(texture: bird[i].texture!,
//                                                    size: bird[i].size)
//                bird[i].physicsBody?.affectedByGravity = false
//                bird[i].physicsBody?.isDynamic = true
//                bird[i].physicsBody?.categoryBitMask = ColliderType.Bird
//                self.addChild(bird[i])
//                bird[i].run(moveForever)
//
//                bird[i].run(SKAction.repeatForever(
//                    SKAction.animate(with: TextureArray_bird, timePerFrame: 0.1)))
//            }
//            if(i == 7){
//                bird.append(SKSpriteNode(imageNamed: "bird1"))
//                bird[i].size = CGSize(width: 50, height: 50)
//                bird[i].position = CGPoint(x: 100 * 9, y:150 * 2.5)
//                bird[i].name = "bird"
//                bird[i].physicsBody = SKPhysicsBody(texture: bird[i].texture!,
//                                                    size: bird[i].size)
//                bird[i].physicsBody?.affectedByGravity = false
//                bird[i].physicsBody?.isDynamic = true
//                bird[i].physicsBody?.categoryBitMask = ColliderType.Bird
//                self.addChild(bird[i])
//                bird[i].run(moveForever)
//
//                bird[i].run(SKAction.repeatForever(
//                    SKAction.animate(with: TextureArray_bird, timePerFrame: 0.1)))
//            }
//            if(i == 8){
//                bird.append(SKSpriteNode(imageNamed: "bird1"))
//                bird[i].size = CGSize(width: 50, height: 50)
//                bird[i].position = CGPoint(x: 100 * 10, y:150 * 2.5)
//                bird[i].name = "bird"
//                bird[i].physicsBody = SKPhysicsBody(texture: bird[i].texture!,
//                                                    size: bird[i].size)
//                bird[i].physicsBody?.affectedByGravity = false
//                bird[i].physicsBody?.isDynamic = true
//                bird[i].physicsBody?.categoryBitMask = ColliderType.Bird
//                self.addChild(bird[i])
//                bird[i].run(moveForever)
//
//                bird[i].run(SKAction.repeatForever(
//                    SKAction.animate(with: TextureArray_bird, timePerFrame: 0.1)))
//            }
//            if(i == 9){
//                bird.append(SKSpriteNode(imageNamed: "bird1"))
//                bird[i].size = CGSize(width: 50, height: 50)
//                bird[i].position = CGPoint(x: 100 * 11, y:150 * 3)
//                bird[i].name = "bird"
//                bird[i].physicsBody = SKPhysicsBody(texture: bird[i].texture!,
//                                                    size: bird[i].size)
//                bird[i].physicsBody?.affectedByGravity = false
//                bird[i].physicsBody?.isDynamic = true
//                bird[i].physicsBody?.categoryBitMask = ColliderType.Bird
//                self.addChild(bird[i])
//                bird[i].run(moveForever)
//
//                bird[i].run(SKAction.repeatForever(
//                    SKAction.animate(with: TextureArray_bird, timePerFrame: 0.1)))
//            }
            
        }
    }

    func touchDown(atPoint pos : CGPoint) {
     
    }
    
    func touchMoved(toPoint pos : CGPoint) {
     
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // this is an event which triggers when user move car/player with cursor  than it reset position of x and y axis
        
        for touch in touches{
            let location = touch.location(in: self)
            car.position.x = location.x
            car.position.y = location.y
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
