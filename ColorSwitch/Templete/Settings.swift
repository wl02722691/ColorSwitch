//
//  Settings.swift
//  ColorSwitch
//
//  Created by 張書涵 on 2018/3/6.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import SpriteKit

enum PhysicsCategory{
    static let none:UInt32 =  0
    static let ballCategory:UInt32 = 0x1 //1
    static let switchCategory:UInt32 = 0x1 << 1

}
