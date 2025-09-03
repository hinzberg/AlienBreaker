//  ScoreSceneTestView.swift
//  AlienBreaker
//  Created by Holger Hinzberg on 01.09.25.

import SwiftUI
import SpriteKit

struct ScoreSceneTestView: View {
    
    @Environment(ScoreEnviroment.self) private var scoreEnv
    
    var body: some View {
        
        VStack (spacing: 0) {
            GeometryReader { geo in
                SpriteView(scene: GetScoreScene(size: geo.size))
            }.frame(height: 40)
        }
        
        Button("Increase Score", action:
                { self.scoreEnv.currentGameScore = self.scoreEnv.currentGameScore + 100 }  )
        .buttonStyle(.bordered)
        
        Button("Increase Level", action:
                { self.scoreEnv.currentLevelNumber = self.scoreEnv.currentLevelNumber + 1 }  )
        .buttonStyle(.bordered)
        
        Button("Increase Lives", action:
                { self.scoreEnv.currentLives = self.scoreEnv.currentLives + 1 }  )
        .buttonStyle(.bordered)
        
        Button("Decrease Lives", action:
                { self.scoreEnv.currentLives = self.scoreEnv.currentLives - 1 }  )
        .buttonStyle(.bordered)
        
    }
    
    func GetBorderScene( size : CGSize) -> SKBorderScene
    {
        let scene = SKBorderScene();
        scene.externalSize = size;
        return scene;
    }
    
    func GetScoreScene( size : CGSize) -> SKScoreScene
    {
        let scene = SKScoreScene();
        scene.externalSize = size;
        scene.scoreEnv = self.scoreEnv
        return scene;
    }
    
}

#Preview {
    ScoreSceneTestView()
}
