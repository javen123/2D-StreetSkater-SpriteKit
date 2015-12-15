//
//  Player.swift
//  MyGameTvOs
//
//  Created by Jim Aven on 12/15/15.
//  Copyright © 2015 Jim Aven. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    //charactrer setup
    let CHAR_X_POS:CGFloat = 130
    let CHAR_Y_POS:CGFloat = 180
    var charPushFrames = [SKTexture]()
    var isJumping = false
    
    convenience init() {
        self.init(imageNamed: "push0")
        setup()
    }
    
    func setup () {
        
        for var x = 0; x < 12; x++ {
            charPushFrames.append(SKTexture(imageNamed: "push\(x)"))
            
        }
        
        self.position = CGPointMake(CHAR_X_POS, CHAR_Y_POS)
        self.zPosition = 10
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(charPushFrames, timePerFrame: 0.1)))
        
        let frontColliderSize = CGSizeMake(5, self.size.height * 0.80)
        let frontCollider = SKPhysicsBody(rectangleOfSize: frontColliderSize, center:CGPointMake(25, 0))
        
        let bottomColliderSize = CGSizeMake(self.size.width / 2, 5)
        let bottomCollider = SKPhysicsBody(rectangleOfSize: bottomColliderSize, center:CGPointMake(0, -(self.size.height / 2) + 5))
        
        self.physicsBody = SKPhysicsBody(bodies: [bottomCollider,frontCollider])
        self.physicsBody?.restitution = 0
        self.physicsBody?.linearDamping = 0.1
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0.1
        self.physicsBody?.dynamic = true
        
        self.physicsBody?.categoryBitMask = GameManager.sharedInstance.COLLIDER_PLAYER
        self.physicsBody?.contactTestBitMask = GameManager.sharedInstance.COLLIDER_OBSTACLE
    }
    
    func jump(){
        
        if isJumping == false {
            isJumping = true
            let impulseX:CGFloat = 0.0
            let impulseY:CGFloat = 60.0
            self.physicsBody?.applyImpulse(CGVectorMake(impulseX, impulseY))
        }
    }
    
    override func update() {
        if isJumping {
            if floor((self.physicsBody?.velocity.dy)!) == 0 {
                isJumping = false
            }
        }
    }
}
