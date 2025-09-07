//
//  SKAccelerometerSceneController.swift
//  AlienBreaker
//
//  Created by Holger Hinzberg on 07.09.25.
//

import UIKit
import SpriteKit

public class SKAccelerometerSceneController
{
    public var strokeColor:SKColor
    public var fillColor:SKColor
    public var strokeThickness:Int

    public var segmentsColors:[SKColor]
    public var segmentsDistance:Int
    
    private var parentScene:SKScene
    private var size:CGSize
    private var centerPoint:CGPoint
    private var storedGaugeValue:Int
    private var segments:[SKShapeNode]
    
    init(scene:SKScene, size:CGSize, centerPoint:CGPoint)
    {
        self.parentScene = scene
        self.size = size
        self.centerPoint = centerPoint
        
        self.strokeThickness = 0
        self.strokeColor = SKColor.red
        self.fillColor = SKColor.black
        self.segmentsDistance = 1
        
        self.segments = [SKShapeNode]()
        self.storedGaugeValue = -100
        
        segmentsColors = [SKColor]()
        segmentsColors.append(SKColor.green)
        segmentsColors.append(SKColor.green)
        segmentsColors.append(SKColor.green)
        segmentsColors.append(SKColor.green)
        segmentsColors.append(SKColor.green)
        segmentsColors.append(SKColor.yellow)
        segmentsColors.append(SKColor.yellow)
        segmentsColors.append(SKColor.yellow)
        segmentsColors.append(SKColor.yellow)
        segmentsColors.append(SKColor.red)
        segmentsColors.append(SKColor.red)
        
        self.createView()
    }
    
    private func createView()
    {
        if self.strokeThickness > 0
        {
            let borderBody = SKShapeNode(rectOf: self.size)
            borderBody.fillColor = self.strokeColor
            borderBody.lineWidth = 0
            borderBody.position = self.centerPoint
            self.parentScene.addChild(borderBody)
        }
        
        // Fill - Background
        let fillSize = CGSize(width: self.size.width - CGFloat(2 * self.strokeThickness)   , height: self.size.height - CGFloat(2 * self.strokeThickness))
        let fillBody = SKShapeNode(rectOf: fillSize)
        fillBody.fillColor = self.fillColor
        fillBody.lineWidth = 0
        fillBody.position = self.centerPoint
        self.parentScene.addChild(fillBody)
    }
    
    func setValue(value:Double)
    {
        var iValue = Int(100 * value)
      
        if iValue > 100
        {
            iValue = 100
        }
        else if iValue < -100
        {
            iValue = -100
        }
        
        if iValue != self.storedGaugeValue
        {
           self.storedGaugeValue = iValue
            self.redrawControl()
        }
    }
    
    private func redrawControl()
    {
        // Remove old
        for segment in self.segments
        {
            segment.removeFromParent()
        }
        
        let fillSize = CGSize(width: self.size.width - CGFloat(2 * self.strokeThickness)   , height: self.size.height - CGFloat(2 * self.strokeThickness))
        let allDistancesWidth = CGFloat(self.segmentsDistance * (self.segmentsColors.count * 2) - self.segmentsDistance)
        
        let avalibleWidth =  CGFloat(fillSize.width - allDistancesWidth)
               
        let segmentsWidth = avalibleWidth / CGFloat(2 * self.segmentsColors.count)
        
        
        let segmentSize = CGSize(width: segmentsWidth, height: fillSize.height - CGFloat(self.segmentsDistance * 2))
        
        let xStart = self.centerPoint.x - CGFloat(segmentsWidth / 2)
        
        // Negative Values - left
        if self.storedGaugeValue < 0
        {
            let precentage = Double(self.storedGaugeValue) * -1.0
            let segCount = Double(self.segmentsColors.count) / 100.0 *  precentage
           let segmentCount = Int(round(segCount))

            for index in 0 ..< segmentCount
            {
                let segment = SKShapeNode(rectOf: segmentSize)
                segment.fillColor = segmentsColors[index]
                segment.lineWidth = 0
                let xOffset = (segmentsWidth + CGFloat(self.segmentsDistance )) * CGFloat(index)
                segment.position = CGPoint(x: xStart - xOffset, y: centerPoint.y )
                self.parentScene.addChild(segment)
                self.segments.append(segment)
            }
        }
        // Positive Values - right
        else if self.storedGaugeValue > 0
        {
            let precentage = Double(self.storedGaugeValue)
            let segCount = Double(self.segmentsColors.count) / 100.0 *  precentage
            let segmentCount = Int(round(segCount))
            
            for index in 0 ..< segmentCount
            {
                let segment = SKShapeNode(rectOf: segmentSize)
                segment.fillColor = segmentsColors[index]
                segment.lineWidth = 0
                let xOffset = (segmentsWidth + CGFloat(self.segmentsDistance )) * CGFloat(index + 1)
                segment.position = CGPoint(x: xStart + xOffset, y: centerPoint.y )
                self.parentScene.addChild(segment)
                self.segments.append(segment)
            }
        }
    }
}
