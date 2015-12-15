//
//  GameScene.swift
//  MyGameTvOs
//
//  Created by Jim Aven on 12/11/15.
//  Copyright (c) 2015 Jim Aven. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //BG setup
    let ASP_PIECES = 15
    let SIDEWALK_PIECES = 24
    let GROUND_X_RESET:CGFloat = -150
    let BG_X_RESET:CGFloat = -912.0
    
    var moveGroundAction:SKAction!
    var moveGroundActionForever:SKAction!
    var backgroundAction = [SKAction]()
    
    var asphaltPieces = [SKSpriteNode]()
    var farBG = [SKSpriteNode]()
    var midBG = [SKSpriteNode]()
    var frontBG = [SKSpriteNode]()
    
    var sidewalkPieces = [SKSpriteNode]()
    var player:Player!
 
    
    override func didMoveToView(view: SKView) {
        
        setupBackground()
        setupGround()
        
        let tap = UITapGestureRecognizer(target: self, action: "tapped:")
        tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
        self.view?.addGestureRecognizer(tap)
        
        player = Player()
        self.addChild(player)
        
        let dumpster = Dumpster()
        self.addChild(dumpster)
        dumpster.startMoving()
        
        self.physicsWorld.gravity = CGVectorMake(0.0, -10)
        self.physicsWorld.contactDelegate = self
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        groundMovement(asphaltPieces, reset: GROUND_X_RESET)
        groundMovement(sidewalkPieces, reset: GROUND_X_RESET)
        groundMovement(farBG, reset: BG_X_RESET)
        groundMovement(midBG, reset: BG_X_RESET)
        groundMovement(frontBG, reset: BG_X_RESET)
        
        for child in self.children {
            child.update()
        }
    }
    
    func setupBackground() {
        
        var action:SKAction!
        
        for var x = 0; x < 3; x++ {
            
            let bg = SKSpriteNode(imageNamed: "bg1")
            bg.position = CGPointMake(CGFloat(x) * bg.size.width, 400)
            bg.zPosition = 3
            frontBG.append(bg)
            action = SKAction.repeatActionForever(SKAction.moveByX(-2.0, y: 0, duration: 0.02))
            bg.runAction(action)
            backgroundAction.append(action)
            self.addChild(bg)
            
            let bg2 = SKSpriteNode(imageNamed: "bg2")
            bg2.position = CGPointMake(CGFloat(x) * bg2.size.width, 450)
            bg2.zPosition = 2
            midBG.append(bg2)
            action = SKAction.repeatActionForever(SKAction.moveByX(-1.0, y: 0, duration: 0.02))
            bg2.runAction(action)
            backgroundAction.append(action)
            self.addChild(bg2)
            
            let bg3 = SKSpriteNode(imageNamed: "bg3")
            bg3.position = CGPointMake(CGFloat(x) * bg3.size.width,500)
            bg3.zPosition = 1
            farBG.append(bg3)
            action = SKAction.repeatActionForever(SKAction.moveByX(-0.5, y: 0, duration: 0.02))
            bg3.runAction(action)
            backgroundAction.append(action)
            self.addChild(bg3)
  
        }
     }
    
    func setupGround() {
        
        moveGroundAction = SKAction.moveByX(GameManager.sharedInstance.MOVEMENT_SPEED, y: 0, duration: 0.02)
        moveGroundActionForever = SKAction.repeatActionForever(moveGroundAction)
        
        
        for var x = 0; x < ASP_PIECES; x++ {
            let asp = SKSpriteNode(imageNamed: "asphalt")
            
            let collider = SKPhysicsBody(rectangleOfSize: CGSizeMake(asp.size.width, 5), center: CGPointMake(0, -20))
            collider.dynamic = false
            
            asp.physicsBody = collider
            
            asphaltPieces.append(asp)
            
            if x == 0 {
                let start = CGPointMake(0, 144)
                asp.position = start
            } else {
                asp.position = CGPointMake(asp.size.width + asphaltPieces[x-1].position.x,asphaltPieces[x-1].position.y)
            }
            asp.runAction(moveGroundActionForever)
            self.addChild(asp)
        }
        
        for var x = 0; x < SIDEWALK_PIECES; x++ {
            let piece = SKSpriteNode(imageNamed: "sidewalk")
            
            self.sidewalkPieces.append(piece)
            
            if x == 0 {
                let start = CGPointMake(0, 190)
                piece.position = start
            } else {
                piece.position = CGPointMake(piece.size.width + sidewalkPieces[x - 1].position.x,sidewalkPieces[x-1].position.y)
            }
            piece.zPosition = 5
            piece.runAction(moveGroundActionForever)
            self.addChild(piece)
        }
    }
    
    func groundMovement(pieceCount:[SKSpriteNode], reset:CGFloat) {
        
        for var x = 0; x < pieceCount.count; x++ {
            var index:Int!
            
            if pieceCount[x].position.x <= reset {
                if x == 0 {
                    index = pieceCount.count - 1
                } else {
                    index = x - 1
                }
                
                let newPos = CGPointMake(pieceCount[index].position.x + pieceCount[x].size.width, pieceCount[x].position.y)
                pieceCount[x].position = newPos
            }
        }
    }
    
    func tapped (gesture:UITapGestureRecognizer){
        player.jump()
        print("tapped")
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE || contact.bodyB.categoryBitMask == GameManager.sharedInstance.COLLIDER_OBSTACLE {
            print("hit")
        }
        
    }
}
