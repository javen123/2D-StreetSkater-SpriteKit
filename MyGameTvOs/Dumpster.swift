//
//  Dumpster.swift
//  MyGameTvOs
//
//  Created by Jim Aven on 12/14/15.
//  Copyright © 2015 Jim Aven. All rights reserved.
//

import SpriteKit

class Dumpster:Obstacle {
    
    convenience init() {
        self.init(imageNamed:"dumpster")
    }
    
    override func initPhysics() {
        
        
        let frontCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(5,self.size.height), center: CGPointMake(-(self.size.width / 2), 0))
        
        let topCollider = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width * 0.80,5), center: CGPointMake(0,self.size.height / 2 - 7))
        self.physicsBody = SKPhysicsBody(bodies: [frontCollider, topCollider])
        
        super.initPhysics()
        
    }
}
