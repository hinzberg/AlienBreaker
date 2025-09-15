//  SKAccelerometerSceneController.swift
//  Created by Holger Hinzberg on 07.09.25.

import UIKit
import SpriteKit

public class SKAccelerometerSceneController
{
    public var strokeColor:SKColor
    public var fillColor:SKColor
    public var strokeThickness:Int

    public var segmentsColors:[SKColor]
    public var segmentWidthDistance:Int
    public var segmentHeightOffset:Int
    
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
        self.strokeColor = SKColor.blue
        self.fillColor = SKColor.black
        
        // Horizontal distance of a segment to the left or right border and to each other
        self.segmentWidthDistance = 2
         // Vertical distance of a segment to the top and botton
        self.segmentHeightOffset = 3
        
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
    }
    
    // This method will be called from the actual CMMotionManager
    func updateValue(value:Double)
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
        self.RemoveOldSeqments();
                
        let fillSize = CGSize(width: self.size.width - CGFloat(2 * self.strokeThickness)   , height: self.size.height - CGFloat(2 * self.strokeThickness))
        let allDistancesWidth = CGFloat(self.segmentWidthDistance * (self.segmentsColors.count * 2) - self.segmentWidthDistance)
        let avalibleWidth =  CGFloat(fillSize.width - allDistancesWidth)
        
        let segmentWidth = avalibleWidth / CGFloat(2 * self.segmentsColors.count)
        let segmentHeight = fillSize.height - CGFloat(self.segmentHeightOffset * 2);
        let segmentSize = CGSize(width: segmentWidth, height:  segmentHeight)
        
        if self.storedGaugeValue < 0
        {
            // Negative Values - left
            self.redrawNegativeValue(segmentSize: segmentSize);
        }
        else if self.storedGaugeValue > 0
        {
            // Positive Values - right
            self.redrawPositiveValue(segmentSize: segmentSize);
        }
    }
    
    private func RemoveOldSeqments()
    {
        for segment in self.segments
        {
            segment.removeFromParent()
        }
    }
        
    private func redrawPositiveValue(segmentSize : CGSize)
    {
        let segmentsWidth = segmentSize.width;
        let xStart = self.centerPoint.x - CGFloat(segmentsWidth / 2)
        let precentage = Double(self.storedGaugeValue)
        let segCount = Double(self.segmentsColors.count) / 100.0 *  precentage
        let segmentCount = Int(round(segCount))
        
        for index in 0 ..< segmentCount
        {
            let segment = SKShapeNode(rectOf: segmentSize)
            segment.fillColor = segmentsColors[index]
            segment.lineWidth = 0
            let xOffset = (segmentsWidth + CGFloat(self.segmentWidthDistance )) * CGFloat(index + 1)
            segment.position = CGPoint(x: xStart + xOffset, y: centerPoint.y )
            self.parentScene.addChild(segment)
            self.segments.append(segment)
        }
    }

    private func redrawNegativeValue(segmentSize : CGSize)
    {
        let segmentsWidth = segmentSize.width;
        let xStart = self.centerPoint.x - CGFloat(segmentsWidth / 2)
        let precentage = Double(self.storedGaugeValue) * -1.0
        let segCount = Double(self.segmentsColors.count) / 100.0 *  precentage
       let segmentCount = Int(round(segCount))

        for index in 0 ..< segmentCount
        {
            let segment = SKShapeNode(rectOf: segmentSize)
            segment.fillColor = segmentsColors[index]
            segment.lineWidth = 0
            let xOffset = (segmentsWidth + CGFloat(self.segmentWidthDistance )) * CGFloat(index)
            segment.position = CGPoint(x: xStart - xOffset, y: centerPoint.y )
            self.parentScene.addChild(segment)
            self.segments.append(segment)
        }
    }
}
