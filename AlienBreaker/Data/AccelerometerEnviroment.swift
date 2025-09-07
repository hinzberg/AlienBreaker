//  AccelerometerEnviroment.swift
//  AlienBreaker
//  Created by Holger Hinzberg on 07.09.25.

import Foundation
import Observation
import CoreMotion

@Observable
class AccelerometerEnviroment {
    
    public var x: Double = 0.0
    public var y: Double = 0.0
    public var z: Double = 0.0
    private var motionManager:CMMotionManager
    
    init() {
        self.motionManager = CMMotionManager()
        self.motionManager.accelerometerUpdateInterval = 0.2
        
        // Start receiving automatic updates
        self.motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
            guard let data = data, error == nil else { return }
            
            self?.x = data.acceleration.x
            self?.y = data.acceleration.y
            self?.z = data.acceleration.z
        }
    }
}
