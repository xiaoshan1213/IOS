//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate{
    
    var audioPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {
        
        let fileName = "note" + String(sender.tag)
        playSound(fileName: fileName)
        
    }
    
    func playSound(fileName: String) {
        
        let soundUrl = Bundle.main.url(forResource: fileName, withExtension: "wav")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl!)
        }
        catch {
            print(error)
        }
        
        //        audioPlayer = try! AVAudioPlayer(contentsOf: soundUrl)
        
        audioPlayer.play()
        
    }
    
  

}

