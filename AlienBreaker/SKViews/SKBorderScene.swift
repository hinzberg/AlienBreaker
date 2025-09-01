//  SKBorderScene.swift
// Use as parent class iIf you want a SpriteKit View with colored borders.
// View also has a Physics body to detect collisions.

import SpriteKit

class SKBorderScene: SKScene {
    
    public var showTop : Bool = true
    public var showBottom : Bool = true
    public var showLeft : Bool = true
    public var showRight : Bool = true
    public var borderColor : SKColor = .red
    public var backColor : SKColor = .black
    public var borderThickness : CGFloat =  4
    
    var externalSize:CGSize?
    
    override func didMove(to view: SKView) {
        
        if let externalSize = self.externalSize {
            self.size = externalSize
        } else {
            self.size = CGSize(width: 400, height: 400)
        }
        
        self.backgroundColor = backColor
        self.SetBorder(borderThickness: self.borderThickness , borderColor: self.borderColor)
    }
    
    func SetBorder( borderThickness : CGFloat, borderColor : SKColor )
    {
        let height:CGFloat = self.size.height
        let width:CGFloat = self.size.width
        
        let yPosTopBorder:CGFloat = height
        let xPosTopBorder:CGFloat = width / 2
        let sizeHorizonalBorder = CGSize(width: width, height: borderThickness)
        let sizeVerticalBorder = CGSize(width: borderThickness, height: height)
        
        if self.showTop {
            // Top
            let topBorderSprite = SKSpriteNode(color: borderColor , size: sizeHorizonalBorder)
            topBorderSprite.position = CGPoint(x: xPosTopBorder, y: yPosTopBorder)
            topBorderSprite.physicsBody = SKPhysicsBody(rectangleOf: topBorderSprite.frame.size)
            topBorderSprite.physicsBody?.isDynamic = false
            topBorderSprite.physicsBody?.categoryBitMask = UICategory
            topBorderSprite.physicsBody?.contactTestBitMask = BallCategory
            addChild(topBorderSprite)
        }
        
        if self.showBottom {
            // Bottom
            let bottomBorderSprite = SKSpriteNode(color: borderColor , size: sizeHorizonalBorder)
            bottomBorderSprite.position = CGPoint(x: xPosTopBorder, y: 0)
            bottomBorderSprite.physicsBody = SKPhysicsBody(rectangleOf: bottomBorderSprite.frame.size)
            bottomBorderSprite.physicsBody?.isDynamic = false
            bottomBorderSprite.physicsBody?.categoryBitMask = UICategory
            bottomBorderSprite.physicsBody?.contactTestBitMask = BallCategory
            addChild(bottomBorderSprite)
        }
        
        if self.showLeft {
            // Left
            let leftBorderSprite = SKSpriteNode(color: borderColor , size: sizeVerticalBorder)
            leftBorderSprite.position = CGPoint(x: 0, y: height / 2)
            leftBorderSprite.physicsBody = SKPhysicsBody(rectangleOf: leftBorderSprite.frame.size)
            leftBorderSprite.physicsBody?.isDynamic = false
            leftBorderSprite.physicsBody?.categoryBitMask = UICategory
            leftBorderSprite.physicsBody?.contactTestBitMask = BallCategory
            addChild(leftBorderSprite)
        }
        
        if self.showRight {
            // Right
            let rightBorderSprite = SKSpriteNode(color: borderColor , size: sizeVerticalBorder)
            rightBorderSprite.position = CGPoint(x: width, y: height / 2)
            rightBorderSprite.physicsBody = SKPhysicsBody(rectangleOf: rightBorderSprite.frame.size)
            rightBorderSprite.physicsBody?.isDynamic = false
            rightBorderSprite.physicsBody?.categoryBitMask = UICategory
            rightBorderSprite.physicsBody?.contactTestBitMask = BallCategory
            addChild(rightBorderSprite)
        }
    }
}
