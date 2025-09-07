//
//  AlienBreakerApp.swift
//  AlienBreaker
//
//  Created by Holger Hinzberg on 01.09.25.
//

import SwiftUI

@main
struct AlienBreakerApp: App {
    
    var scoreEnvironment = ScoreEnviroment()
    var accelerometerEnviroment = AccelerometerEnviroment()
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            //ScoreSceneTestView()
            AccelerometerSceneTestView()
                .environment(scoreEnvironment)
                .environment(accelerometerEnviroment)
        }
    }
}
