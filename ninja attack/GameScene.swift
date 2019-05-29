//
//  GameScene.swift
//  ninja attack
//
//  Created by EDUARDO MENDOZA on 5/13/19.
//  Copyright © 2019 EDUARDO MENDOZA. All rights reserved.
//

import SpriteKit
import GameplayKit
struct PhysicdCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let monster: UInt32 = 0b1
    static let projectile: UInt32 = 0b10
}

class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "ninja")
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        addChild(player)
        
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run(addMonster),
            SKAction.wait(forDuration: 1.0)])
        ))
    }

    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }

    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max-min) + min
    }
    
    func addMonster() {
        let monster = SKSpriteNode(imageNamed: "enemy")
        let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
        addChild(monster)
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let moveAction = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY), duration: TimeInterval(actualDuration))
        let moveActionDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([moveAction, moveActionDone]))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        let projectile = SKSpriteNode(imageNamed: "star")
        projectile.position = player.position
        var offset = touchLocation - projectile.position
        
        if (offset.x < 0) {
            return
        }
        
        addChild(projectile)
        let direction = offset.normalized()
        let shootAmount = direction*1000
        let realDestination = shootAmount + projectile.position
        let actionMove = SKAction.move(to: realDestination, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    
    
    
    
    
}
    
