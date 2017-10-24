//
//  ViewController.swift
//  Magic8Ball
//
//  Created by Sam Ma on 10/23/17.
//  Copyright © 2017 Sam Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var magicBallImg: UIImageView!
    let ballArr = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    var randomNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func askClicked(_ sender: UIButton) {
        getAnswer()
//        print(randomNum)
    }
    
    func getAnswer() {
        randomNum = Int(arc4random_uniform(5))
        magicBallImg.image = UIImage(named: ballArr[randomNum])
    }
    
}

