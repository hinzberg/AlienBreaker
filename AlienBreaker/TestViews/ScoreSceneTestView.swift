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
        
        VStack(spacing: 15) {
            Button("Increase Score") {
                scoreEnv.currentGameScore += 100
            }.redButtonStyle()
            
            Button("Increase Level") {
                scoreEnv.currentLevelNumber += 1
            }.redButtonStyle()
            
            Button("Increase Lives") {
                scoreEnv.currentLives += 1
            }.redButtonStyle()
            
            Button("Decrease Lives") {
                scoreEnv.currentLives -= 1
            }.redButtonStyle() 
        }
        .buttonStyle(.bordered)
        .frame(maxWidth: .infinity) // Make all buttons expand horizontally
        .padding(20)
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
