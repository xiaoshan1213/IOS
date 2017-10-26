//
//  ViewController.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var currentStory : Int = 1
    let storyBank = StoryBank()
    
    // UI Elements linked to the storyboard
    @IBOutlet weak var topButton: UIButton!         // Has TAG = 1
    @IBOutlet weak var bottomButton: UIButton!      // Has TAG = 2
    @IBOutlet weak var storyTextView: UILabel!
    
    // TODO Step 5: Initialise instance variables here
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO Step 3: Set the text for the storyTextView, topButton, bottomButton, and to T1_Story, T1_Ans1, and T1_Ans2
        updateUI()
        
    }

    
    // User presses one of the buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.tag == 1 {
            currentStory = storyBank.storyCahin[currentStory]![0]
        }
        else {
            currentStory = storyBank.storyCahin[currentStory]![1]
        }
        updateUI()
    
    }
    
    func updateUI() {
        
        storyTextView.text = storyBank.storyBank[currentStory]?.story
        topButton.isHidden = false
        bottomButton.isHidden = false
        if checkEnd() {
            topButton.isHidden = true
            bottomButton.isHidden = true
        }
        else {
            topButton.setTitle(storyBank.storyBank[currentStory]?.ans1, for: .normal)
            bottomButton.setTitle(storyBank.storyBank[currentStory]?.ans2, for: .normal)
        }
    }
    
    func checkEnd() -> Bool {
        
        if storyBank.storyCahin[currentStory] == nil {
            
            let alert = UIAlertController(title: "Congrats!", message: "You've reached the end of story.", preferredStyle: .alert)
            let restartAct = UIAlertAction(title: "restart", style: .default, handler: { (UIAlertAction) in
                self.restart()
            })
            alert.addAction(restartAct)
            present(alert, animated: true, completion: nil)
            return true
            
        }
        
        return false
    }
    
    func restart() {
        currentStory = 1
        updateUI()
    }
    



}

