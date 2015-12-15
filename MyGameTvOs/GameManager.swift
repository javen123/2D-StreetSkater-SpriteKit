//
//  GameManager.swift
//  MyGameTvOs
//
//  Created by Jim Aven on 12/15/15.
//  Copyright © 2015 Jim Aven. All rights reserved.
//

import SpriteKit

class GameManager {
    static let sharedInstance = GameManager()
    
    let MOVEMENT_SPEED:CGFloat = -8.5
    
    //Colliders
    
    let COLLIDER_OBSTACLE:UInt32 = 1 << 0
    let COLLIDER_PLAYER:UInt32 = 1 << 1
}
