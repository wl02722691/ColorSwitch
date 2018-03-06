//
//  GameScene.swift
//  ColorSwitch
//
//  Created by 張書涵 on 2018/3/2.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import SpriteKit

enum PlayColors {
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0),
    ]
}

enum SwitchState: Int{
    case red, yellow, green ,blue
}

class GameScene: SKScene {
    
    var colorSwitch:SKSpriteNode!//讓colorSwitch服從SKSpriteNode
    var switchState = SwitchState.red
    var currentColorIndex:Int?
    
    let scoreLabel = SKLabelNode(text: "0")
    var score = 0
    
    override func didMove(to view: SKView) {
        setupPhysics()
        layoutScene()//call layoutScene function
    }
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)//球落下的速度慢一點
        physicsWorld.contactDelegate = self
        
    }
    
    func layoutScene(){
        backgroundColor = UIColor(red: 44/225, green: 62/225, blue: 80/225, alpha: 1)//背景
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")//SKSpriteNode加colorSwitch
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)//colorSwitch大小
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY+colorSwitch.size.width)//colorSwitch位置
        colorSwitch.zPosition = ZPositions.colorSwitchs
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategory.switchCategory
        colorSwitch.physicsBody?.isDynamic = false//讓colorSwitch不被影響不落下
        addChild(colorSwitch)//用addChild加colorSwitch到畫面上
        
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 60.0
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.zPosition = ZPositions.label
        addChild(scoreLabel)
        
        spawnBall()//call spawnBall function
    }
    func updateScoreLabel(){
        scoreLabel.text = "\(score)"
    }
    
    
    func spawnBall(){
        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        
        let ball = SKSpriteNode(texture: SKTexture(imageNamed:"ball"), color: PlayColors.colors[currentColorIndex!], size: CGSize(width: 30, height: 30))
        ball.colorBlendFactor = 1.0
        ball.name = "ball"
        ball.size = CGSize(width: 30, height: 30)//ball大小
        ball.position = CGPoint(x: frame.midX, y: frame.maxY)//ball位置
        ball.zPosition = ZPositions.ball
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2) //15
        ball.physicsBody?.categoryBitMask = PhysicsCategory.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategory.none
        addChild(ball)//用addChild加ball到畫面上
        //        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
//        ball.physicsBody?.restitution = 1
    }
    func turnWheel(){
        if let newState = SwitchState(rawValue:switchState.rawValue + 1){
            switchState = newState
        }else{
            switchState = .red
        }
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
    }
    
    func gameOver(){
        print("GameOver!")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
}

extension GameScene:SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) { //print("Correct!")｜｜判斷gameOver()
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
     
        if contactMask == PhysicsCategory.ballCategory | PhysicsCategory.switchCategory{
            if let ball =  contact.bodyA.node?.name == "Ball" ?
            contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode{
                if currentColorIndex == switchState.rawValue{
                    score += 1
                    updateScoreLabel()
                    
                    print("Correct!")
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion: {
                        ball.removeFromParent()
                        self.spawnBall()
                    })
                }else{
                    gameOver()
                }
            }
        }
    }
}
