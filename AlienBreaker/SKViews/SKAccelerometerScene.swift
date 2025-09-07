//  SKAccelerometerScene.swift
//  AlienBreaker
//  Created by Holger Hinzberg on 07.09.25.

import Foundation
import SpriteKit
import CoreMotion

class SKAccelerometerScene : SKBorderScene , ObservableObject {
    
    public var accelerometerEnv : AccelerometerEnviroment?
    private var accelerometerControler:SKAccelerometerSceneController?
    private let baseBorderColor = SKColor.red
    private let bgColor = SKColor.black
    private let baseBorderThickness = 4.0
    
    override func didMove(to view: SKView)
    {
        super.didMove(to: view)
        super.SetBorder(borderThickness: self.baseBorderThickness, borderColor: self.baseBorderColor)
        
        let controlsize = CGSize(width: self.size.width - 10 , height: 20)
        let centerpoint = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height / 2)
        self.accelerometerControler = SKAccelerometerSceneController(scene: self, size: controlsize, centerPoint: centerpoint)
    }

    // Autoupdate of the SpriteKit Scene
    // Will be used to update the Scene Controller
    override func update(_ currentTime: TimeInterval)
    {
        let x = self.accelerometerEnv?.x
        if let xValue = x
        {
            self.accelerometerControler?.setValue(value: xValue)
        }
    }
}
