//
//  GridVIew.swift
//  game of life
//
//  Created by Sam Ma on 5/6/17.
//  Copyright © 2017 Sam Ma. All rights reserved.
//

import UIKit

class GridView: UIView {
    let STROKE_WIDTH: Int = 1;
    let MARGIN_OFFSET_NUMBER: Int = 2;
    var gridState: GridState?;
    var imageSide: Float = 0;
    var marginOffsetLength: Float = 0;
    var cellSideLength: Float = 0;
    
    
    
    func setParams(imageSide: Float, gridState: GridState) {
        
        self.imageSide = imageSide;
        self.gridState = gridState;
        marginOffsetLength = self.imageSide / Float(self.gridState!.COLUMN_NUMBER + MARGIN_OFFSET_NUMBER) * Float(MARGIN_OFFSET_NUMBER) / 2.0;
        cellSideLength = self.imageSide / Float(self.gridState!.COLUMN_NUMBER + MARGIN_OFFSET_NUMBER);
        
    }
    
    
    override func draw(_ rect: CGRect) {
        
        
        let context = UIGraphicsGetCurrentContext()!;
        context.setLineWidth(CGFloat(STROKE_WIDTH));
        context.setStrokeColor(UIColor.black.cgColor);
        
        
        
        for i in 0 ... self.gridState!.ROW_NUMBER {
            
            context.move(to: CGPoint(x: CGFloat(marginOffsetLength), y: CGFloat(marginOffsetLength + Float(i) * cellSideLength)));
            context.addLine(to: CGPoint(x: CGFloat(imageSide - Float(marginOffsetLength)), y: CGFloat(marginOffsetLength + Float(i) * cellSideLength)));
            context.strokePath();
        }
        
        for i in 0 ... self.gridState!.COLUMN_NUMBER {
            
            context.move(to: CGPoint(x: CGFloat(marginOffsetLength + Float(i) * cellSideLength), y: CGFloat(marginOffsetLength)));
            context.addLine(to: CGPoint(x: CGFloat(marginOffsetLength + Float(i) * cellSideLength), y: CGFloat(Float(self.gridState!.COLUMN_NUMBER) * cellSideLength + marginOffsetLength)));
            context.strokePath();
            
            
        }
        
        
        
        context.setStrokeColor(UIColor.red.cgColor);
        
        
        
        for i in 0 ..< self.gridState!.ROW_NUMBER {
            for j in 0 ..< self.gridState!.COLUMN_NUMBER {
                
                
                if (self.gridState!.isLive(i: i, j: j)) {
                    
                    context.addArc(center: CGPoint(x: CGFloat(marginOffsetLength + Float(j) * cellSideLength + cellSideLength / 2.0),
                                                    y: CGFloat(marginOffsetLength + Float(i) * cellSideLength + cellSideLength / 2.0)),
                                    radius: CGFloat(cellSideLength / 2 * 90 / 100), startAngle: 0, endAngle: CGFloat(2.0 * .pi), clockwise: false);
                    context.setFillColor(UIColor.red.cgColor);
                    
                    
                    context.fillPath();
                    
                }
                
            }
        }
        
    }
    
    
    func getIndex(x: Float, y: Float) -> (j: Int, i: Int){
        var i: Int = Int ((x - marginOffsetLength) / cellSideLength);
        var j: Int = Int ((y - marginOffsetLength) / cellSideLength);
        
        if ((i >= self.gridState!.ROW_NUMBER) || (j >= self.gridState!.COLUMN_NUMBER)) { return (-1, -1); }
        
        return (i, j);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for i in 0 ..< touches.count {
            
            let first = (touches as NSSet).allObjects[i] as! UITouch
            
            let firstPoint = first.location(in: self);
            
            let index = getIndex(x: Float(firstPoint.x), y: Float(firstPoint.y));
            
            
            if ((-1 == Int(index.i)) || (-1 == Int(index.j))) { continue; }
            gridState?.changeState(i: Int(index.i), j: Int(index.j));
            
        }
        
        
        setNeedsDisplay();
    }
}
