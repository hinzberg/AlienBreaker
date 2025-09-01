//  ScoreSceneTestView.swift
//  AlienBreaker
//  Created by Holger Hinzberg on 01.09.25.

import SwiftUI
import SpriteKit

struct ScoreSceneTestView: View {
    
    var body: some View {
        
        VStack (spacing: 0) {
            GeometryReader { geo in
                SpriteView(scene: GetBorderScene(size: geo.size))
            }.frame(height: 100)
        }
    }
    
    func GetBorderScene( size : CGSize) -> SKBorderScene
    {
        let scene = SKBorderScene();
        scene.externalSize = size;
        return scene;
    }
    
}

#Preview {
    ScoreSceneTestView()
}
