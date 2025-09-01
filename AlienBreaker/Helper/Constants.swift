//
//  Constants.swift
//  SwiftBricks
//
//  Created by Holger Hinzberg on 25.01.15.
//  Copyright (c) 2015 Holger Hinzberg. All rights reserved.
//

import Foundation

let BallCategory:UInt32 = 0x1
let BrickCategory:UInt32 = 0x1 << 1
let PaddleCategory:UInt32 = 0x1 << 2
let GapCategory:UInt32 = 0x1 << 3
let UICategory:UInt32 = 0x1 << 4

enum LevelStartState
{
    case StartNewLevel
    case RestartLevel
}

enum GameEvent
{
    case None
    case ExtraLife
}

enum GameState
{
    case Setup
    case Prepare
    case Running
    case Stopped
}

enum SpriteMoveDirection
{
    case Right
    case Left
    case Down
    case Up
}
