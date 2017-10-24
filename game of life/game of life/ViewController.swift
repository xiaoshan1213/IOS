//
//  ViewController.swift
//  game of life
//
//  Created by Sam Ma on 5/6/17.
//  Copyright © 2017 Sam Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gridState: GridState = GridState();
    var gridView: GridView?;
    var gridSize: CGFloat = 0;
    var screenWidth: CGFloat = 0;
    var screenHeight: CGFloat = 0;
    let BUTTON_WIDTH: CGFloat = 100;
    let BUTTON_HEIGHT: CGFloat = 50;
    var heightOffset: CGFloat = 0;
    var leftOffset: CGFloat = 0;
    var btnNextX: CGFloat = 0;
    var btnNextY: CGFloat = 0;
    var btnResetX: CGFloat = 0;
    var btnResetY: CGFloat = 0;
    var buttonReset: UIButton = UIButton();
    var buttonNext: UIButton = UIButton();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        screenWidth = self.view.frame.width;
        screenHeight = self.view.frame.height;
        
        
        if (screenHeight < screenWidth) {
            gridSize = screenHeight;
            heightOffset = 0;
            leftOffset = 50;
            btnResetY = (screenHeight / 2.0 - BUTTON_HEIGHT) / 2.0;
            btnResetX = screenWidth + leftOffset + (screenWidth - screenHeight - BUTTON_WIDTH - leftOffset) / 2.0;
            btnNextX = btnResetX;
            btnNextY = btnResetY + screenHeight / 2.0;
            
        } else {
            gridSize = screenWidth;
            leftOffset = 0;
            heightOffset = 50;
            btnResetY = screenWidth + heightOffset + (screenHeight - screenWidth - BUTTON_HEIGHT - heightOffset) / 2.0;
            btnResetX = (screenWidth / 2.0 - BUTTON_WIDTH) / 2.0;
            btnNextX = btnResetX + screenWidth / 2.0;
            btnNextY = btnResetY;
            
        }
        
        
        gridView = GridView(frame: CGRect(x: leftOffset, y: heightOffset, width: gridSize, height: gridSize));
        gridView!.setParams(imageSide: Float(gridSize), gridState: gridState)
        gridView!.backgroundColor = UIColor.white;
        self.view.addSubview(gridView!);
        
        buttonReset.frame = CGRect(x: btnResetX, y: btnResetY, width: BUTTON_WIDTH, height: BUTTON_HEIGHT)
        buttonReset.backgroundColor = UIColor.gray
        buttonReset.setTitle("Reset", for: .normal)
        buttonReset.addTarget(self, action: #selector(reset), for: .touchUpInside)
        self.view.addSubview(buttonReset)
        
        
        
        buttonNext.frame = CGRect(x: btnNextX, y: btnNextY, width: BUTTON_WIDTH, height: BUTTON_HEIGHT)
        buttonNext.backgroundColor = UIColor.gray
        buttonNext.setTitle("Next", for: .normal)
        buttonNext.addTarget(self, action: #selector(nextGeneration), for: .touchUpInside)
        self.view.addSubview(buttonNext)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        
        screenWidth = self.view.frame.height;
        screenHeight = self.view.frame.width;
        
        
        if (screenHeight < screenWidth) {
            gridSize = screenHeight;
            heightOffset = 0;
            leftOffset = 50;
            btnResetY = (screenHeight / 2.0 - BUTTON_HEIGHT) / 2.0;
            btnResetX = screenHeight + leftOffset + (screenWidth - screenHeight - BUTTON_WIDTH - leftOffset) / 2.0;
            btnNextX = btnResetX;
            btnNextY = btnResetY + screenHeight / 2.0;
            
        } else {
            gridSize = screenWidth;
            leftOffset = 0;
            heightOffset = 50;
            btnResetY = screenWidth + heightOffset + (screenHeight - screenWidth - BUTTON_HEIGHT - heightOffset) / 2.0;
            btnResetX = (screenWidth / 2.0 - BUTTON_WIDTH) / 2.0;
            btnNextX = btnResetX + screenWidth / 2.0;
            btnNextY = btnResetY;
            
        }
        
        print("change orientation!!!!!!!!!!!!!");
        
        print(leftOffset);
        print(heightOffset);
        
        gridView!.frame = CGRect(x: leftOffset, y: heightOffset, width: gridSize, height: gridSize);
        buttonReset.frame = CGRect(x: btnResetX, y: btnResetY, width: BUTTON_WIDTH, height: BUTTON_HEIGHT);
        buttonNext.frame = CGRect(x: btnNextX, y: btnNextY, width: BUTTON_WIDTH, height: BUTTON_HEIGHT);
        
        gridView!.setNeedsDisplay();
        buttonReset.setNeedsDisplay();
        buttonNext.setNeedsDisplay();
        
    }
    
    
    
    func reset(sender: UIButton!) {
        let alertController = UIAlertController(title: "Alert", message: "Do you want to reset the game?", preferredStyle: UIAlertControllerStyle.alert)
        let canCelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {(UIAlertAction) -> Void in
            self.gridState.initGrid();
            self.dismiss(animated: true, completion: nil)
            self.gridView!.setNeedsDisplay()
        })
        
        alertController.addAction(canCelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated:true, completion:nil)
    }
    
    func nextGeneration(sender: UIButton!) {
        
        gridState.nextGeneration();
        gridView!.setNeedsDisplay()
        
        
    }
    
    
}
