//
//  AccelerometerSceneTestView.swift
//  AlienBreaker
//
//  Created by Holger Hinzberg on 07.09.25.
//

import SwiftUI
import SpriteKit

struct AccelerometerSceneTestView: View {
    
    @Environment(AccelerometerEnviroment.self) private var accelerometerEnv
    
    var body: some View {
        
        VStack (spacing: 0) {
            GeometryReader { geo in
                SpriteView(scene: GetAccelerometerScene(size: geo.size))
            }.frame(height: 50)
        }
    }
    
    func GetAccelerometerScene( size : CGSize) -> SKAccelerometerScene
    {
        let scene = SKAccelerometerScene();
        scene.externalSize = size;
        scene.accelerometerEnv = self.accelerometerEnv
        return scene;
    }
}

#Preview {
    AccelerometerSceneTestView()
}
