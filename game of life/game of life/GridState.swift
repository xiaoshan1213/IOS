//
//  GridState.swift
//  game of life
//
//  Created by Sam Ma on 5/6/17.
//  Copyright © 2017 Sam Ma. All rights reserved.
//

import UIKit

class GridState {
    
    
    let COLUMN_NUMBER: Int = 12;
    let ROW_NUMBER: Int = 12;
    let LIVE: Int = 1;
    let DEAD: Int = 0;
    let UNDERPOPULATION_NEIGHBOR_NUMBER: Int = 2;
    let OVERPOPULATION_NEIGHBOR_NUMBER: Int = 3;
    let REPRODUCTION_NEIGHBOR_NUMBER: Int = 3;
    var grid: [[Int]];
    
    init() {
        
        grid = Array(repeating: Array(repeating: 0, count: COLUMN_NUMBER), count: ROW_NUMBER);
        initGrid();
    }
    
    func initGrid() {
        
        for i in 0 ..< ROW_NUMBER{
            
            for j in 0 ..< COLUMN_NUMBER{
                grid[i][j] = DEAD;
            }
        }
        
    }
    
    
    func isLive(i: Int, j: Int) -> Bool {
        
        if ((i >= ROW_NUMBER) || (j >= COLUMN_NUMBER)) { return false; }
        
        if (LIVE == grid[i][j]) { return true; }
        
        return false;
        
    }
    
    func countNeighbor(i: Int, j: Int) -> Int {
        
        var direction: [[Int]] = [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [-1, -1], [-1, 0], [-1, 1]];
        var newI: Int = 0;
        var newJ: Int = 0;
        var neighborNum: Int = 0;
        
        for k in 0 ..< direction.count {
            
            newI = i + direction[k][0];
            newJ = j + direction[k][1];
            
            if ((newI < 0) || (newI >= ROW_NUMBER)) { continue; }
            if ((newJ < 0) || (newJ >= COLUMN_NUMBER)) { continue; }
            
            if (LIVE == grid[newI][newJ]) { neighborNum = neighborNum + 1; }
        }
        
        return neighborNum;
        
    }
    
    
    func nextGeneration() {
        
        var newGrid: [[Int]] = Array(repeating: Array(repeating: 0, count: COLUMN_NUMBER), count: ROW_NUMBER);
        var neighborNum: Int = 0;
        
        for i in 0 ..< ROW_NUMBER {
            
            for j in 0 ..< COLUMN_NUMBER {
                
                neighborNum = countNeighbor(i: i, j: j);
                newGrid[i][j] = grid[i][j];
                
                if (LIVE == grid[i][j]) {
                    
                    if ((neighborNum < UNDERPOPULATION_NEIGHBOR_NUMBER) || (neighborNum > OVERPOPULATION_NEIGHBOR_NUMBER)) {
                        newGrid[i][j] = DEAD;
                    }
                } else {
                    
                    if (REPRODUCTION_NEIGHBOR_NUMBER == neighborNum) {
                        newGrid[i][j] = LIVE;
                    }
                }
            }
        }
        
        grid = newGrid;
        
        return;
        
    }
    
    
    func changeState(i: Int, j: Int){
        
        if ((i >= ROW_NUMBER) || (j >= COLUMN_NUMBER)) { return; }
        
        if (DEAD == grid[i][j]) {
            
            print("change to live");
            
            grid[i][j] = LIVE;
            
        } else {
            print("change to dead");
            grid[i][j] = DEAD;
            
        }
        
        return;
        
    }
    
    
    
    
    
    
}

