//  ScoreView.swift
//  BricksAndBalls
//  Created by Holger Hinzberg on 21.04.21.

import SwiftUI
import SpriteKit

class SKScoreScene : SKBorderScene, ObservableObject {
    
    // Score and Level Label side margins
    private let labelMarging : CGFloat = 10
    
    // Score
    var scoreEnv: ScoreEnviroment?
    
    private var levelLabel:SKLabelNode?
    private var scoreLabel:SKLabelNode?
    
    private var displayedScore:Int = 0
    private var shouldDisplayedScore:Int = 0
    private var displayedLives:Int = 0
    private var displayedLevelNumber:Int = 0
    
    private var livesIndicatorNodes:[SKShapeNode]?
    
    // To increase score value animated
    private var lastUpdateTimeInterval:TimeInterval?
    private var numberFormatter:NumberFormatter?
    
    private var textColor = SKColor.yellow
    private var livesIndicatorColor = SKColor.white
    private var baseBorderColor = SKColor.red
    private var bgColor = SKColor.black
    
    override func didMove(to view: SKView)
    {
        // Initialize SKBorderScene
        super.didMove(to: view)
        super.SetBorder(borderThickness: 4, borderColor: self.baseBorderColor)
        
        self.numberFormatter = NumberFormatter()
        self.numberFormatter?.numberStyle = NumberFormatter.Style.decimal
        self.numberFormatter?.locale = NSLocale.current
        
        self.lastUpdateTimeInterval = CFAbsoluteTimeGetCurrent()
        self.livesIndicatorNodes = [SKShapeNode]()
        self.backgroundColor = self.bgColor
                
        self.createScoreLabel()
        self.createLevelLabel()
        self.updateLivesDisplay()
    }
    
    // Update function, will be called automaticly
    override func update(_ currentTime: CFTimeInterval)
    {
        self.updateScoreDisplay()
        self.updateLevelDisplay()
        self.updateLivesDisplay()
    }
    
    private func createScoreLabel()
    {
        self.scoreLabel = SKLabelNode(fontNamed: "Futura Medium")
        self.scoreLabel?.physicsBody?.categoryBitMask = UICategory
        self.scoreLabel?.fontSize = 18
        self.scoreLabel?.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        self.scoreLabel?.fontColor = self.textColor
        self.scoreLabel?.color = .white
        let positionX : CGFloat = self.labelMarging
        let positionY : CGFloat = (self.size.height / 2) - 8
        self.scoreLabel?.position = CGPoint(x: positionX, y: positionY)
        self.scoreLabel?.zPosition = 100
        self.addChild(self.scoreLabel!)
        let number = NSNumber(value: displayedScore)
        let formattedScore = self.numberFormatter?.string(from: number)
        if let score = formattedScore
        {
            self.scoreLabel?.text = "Score \(score)"
        }
    }
    
    private func createLevelLabel()
    {
        self.levelLabel = SKLabelNode(fontNamed: "Futura Medium")
        self.levelLabel?.physicsBody?.categoryBitMask = UICategory
        self.levelLabel?.fontSize = 18
        self.levelLabel?.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        self.levelLabel?.fontColor = self.textColor
        let positionX : CGFloat = self.size.width - self.labelMarging
        let positionY : CGFloat = (self.size.height / 2) - 8;
        self.levelLabel?.position = CGPoint(x: positionX, y: positionY)
        self.levelLabel?.zPosition = 10
        self.levelLabel?.text = "Level \(self.displayedLevelNumber)"
        self.addChild(self.levelLabel!)
    }
    
    func updateLevelDisplay()
    {
        if (self.displayedLevelNumber != self.scoreEnv!.currentLevelNumber)
        {
            self.displayedLevelNumber = self.scoreEnv!.currentLevelNumber
            self.levelLabel?.text = "Level \(self.displayedLevelNumber)"
            print("Updating Level to \(self.displayedLevelNumber)")
        }
    }
    
    func updateScoreDisplay()
    {
        self.shouldDisplayedScore = self.scoreEnv!.currentGameScore
        
        // The Score that should be shown is already the score that is shown
        if (self.displayedScore == self.shouldDisplayedScore)
        {
            return
        }
        
        print("Updating Score to \(self.shouldDisplayedScore)")
        
        let remainingScore = self.shouldDisplayedScore - self.displayedScore
        
        var incrementScorePerInterval = remainingScore / 3
        if remainingScore > 0 && incrementScorePerInterval == 0 {
            incrementScorePerInterval = remainingScore
        }
        
        let currentTime:CFTimeInterval = CFAbsoluteTimeGetCurrent();
        let timeSinceLast:CFTimeInterval = currentTime - self.lastUpdateTimeInterval!;
        
        // Enough time elapsed for an update of the score display?
        if (timeSinceLast > 0.05)
        {
            self.lastUpdateTimeInterval = currentTime;
            if (self.displayedScore >= shouldDisplayedScore)
            {
                // score value reached
                let number = NSNumber(value: self.displayedScore)
                let formattedScore = self.numberFormatter?.string(from: number)
                if let score = formattedScore
                {
                    self.scoreLabel?.text = "Score \(score)"
                }
            }
            else
            {
                // score value not reached, increment more
                self.displayedScore += incrementScorePerInterval;
                let number = NSNumber(value: self.displayedScore)
                let formattedScore = self.numberFormatter?.string(from: number)
                if let score = formattedScore
                {
                    self.scoreLabel?.text = "Score \(score)"
                }
            }
        }
    }
    
    func updateLivesDisplay()
    {
        if (self.displayedLives == self.scoreEnv!.currentLives)
        {
            return
        }
        
        self.displayedLives = self.scoreEnv!.currentLives
        
        print("Updating Lives to \(self.displayedLives)")
        
        let dotDiameter:Double = 4
        let dotDistance:Double = 6
        
        // Die alten Indikatoren entfernen
        for node:SKShapeNode in self.livesIndicatorNodes!
        {
            node.removeFromParent()
        }
        self.livesIndicatorNodes!.removeAll(keepingCapacity: true)
        
        let count = self.displayedLives
        
        let center:Double = Double(self.size.width / 2)
        
        var offsetFromCenter = dotDiameter  * Double(count)
        offsetFromCenter += (dotDistance ) * Double(count)
        offsetFromCenter = offsetFromCenter / 2
        
        let startX:Double = Double(center - offsetFromCenter)
        let startY:CGFloat = self.size.height / 2
        
        for i in 0 ..< count
        {
            let offsetX = dotDiameter + (dotDistance * 2) * Double(i)
            let xPos:CGFloat = CGFloat(startX + offsetX)
            let circle:SKShapeNode = SKShapeNode(circleOfRadius: CGFloat(dotDiameter))
            circle.fillColor = self.livesIndicatorColor
            circle.strokeColor = self.livesIndicatorColor
            circle.position = CGPoint(x: xPos, y: startY)
            circle.physicsBody?.categoryBitMask = UICategory
            circle.zPosition = 100
            self.addChild(circle)
            self.livesIndicatorNodes!.append(circle)
        }
    }
}
