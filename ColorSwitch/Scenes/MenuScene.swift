//
//  MenuScene.swift
//  ColorSwitch
//
//  Created by 張書涵 on 2018/3/6.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/225, green: 62/225, blue: 80/225, alpha: 1)//背景
        addLogo()
        addLabels()
    }
    
    func addLogo(){
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        addChild(logo)
    }
    
    func addLabels(){
        let playLabel = SKLabelNode(text: "Tap to Play!")
        playLabel.fontName = "AvenNext-Bold"
        playLabel.fontSize = 50.0
        playLabel.color = UIColor.white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        
        let highscore = SKLabelNode(text: "Highscore:")
        highscore.fontName = "AvenNext-Bold"
        highscore.fontSize = 40.0
        highscore.color = UIColor.white
        highscore.position = CGPoint(x: frame.midX, y: frame.midY - highscore.frame.size.height*4)
        addChild(highscore)
        
        
        let recentScoreLabel = SKLabelNode(text: "Recent Score:")
        recentScoreLabel.fontName = "AvenNext-Bold"
        recentScoreLabel.fontSize = 40.0
        recentScoreLabel.color = UIColor.white
        recentScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - recentScoreLabel.frame.size.height*2)
        addChild(recentScoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view?.presentScene(gameScene)
    }
}
