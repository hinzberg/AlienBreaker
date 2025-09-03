//
//  ScoreEnviroment.swift
//  AlienBreaker
//
//  Created by Holger Hinzberg on 02.09.25.
//

import Foundation
import Observation

@Observable
class ScoreEnviroment {
    
    public var currentGameScore:Int
    public var currentLevelNumber:Int
    public var currentLives:Int
    
    init()
    {
        self.currentGameScore = 1000
        self.currentLevelNumber = 1
        self.currentLives = 4
    }
}
