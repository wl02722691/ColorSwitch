//
//  GameScene.swift
//  ColorSwitch
//
//  Created by 張書涵 on 2018/3/2.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var colorSwitch:SKSpriteNode!//讓colorSwitch服從SKSpriteNode
    
    override func didMove(to view: SKView) {
        setupPhysics()
        layoutScene()//call layoutScene function
    }
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)//球落下的速度慢一點
        physicsWorld.contactDelegate = self
        
    }
    
    func layoutScene(){
        backgroundColor = UIColor(red: 44/225, green: 62/225, blue: 80/225, alpha: 1)//背景
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")//SKSpriteNode加colorSwitch
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)//colorSwitch大小
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY+colorSwitch.size.width)//colorSwitch位置
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategory.switchCategory
        colorSwitch.physicsBody?.isDynamic = false//讓colorSwitch不被影響不落下
        addChild(colorSwitch)//用addChild加colorSwitch到畫面上
        
        spawnBall()//call spawnBall function
    }
    
    func spawnBall(){
        let ball = SKSpriteNode(imageNamed: "ball")//SKSpriteNode加ball
        ball.size = CGSize(width: 30, height: 30)//ball大小
        ball.position = CGPoint(x: frame.midX, y: frame.maxY)//ball位置
        addChild(ball)//用addChild加ball到畫面上
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2) //15
        ball.physicsBody?.categoryBitMask = PhysicsCategory.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategory.none
//        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
//        ball.physicsBody?.restitution = 1
    }
}

extension GameScene:SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.contactTestBitMask
        if contactMask == PhysicsCategory.ballCategory | PhysicsCategory.switchCategory{
            print("Kontakt!")
        }
    }
}
