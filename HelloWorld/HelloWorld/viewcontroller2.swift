//
//  ViewController.swift
//  HelloWorld
//
//  Created by Sam Ma on 4/13/17.
//  Copyright © 2017 Sam Ma. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"background")!)
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        //        let title = UILabel()
        //        title.text = "HelloWorld from Wenjin"
        //        title.center = self.view.center
        //        title.backgroundColor = UIColor.red
        //        title.sizeToFit()
        //        self.view.addSubview(title)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        let co:Int? = 1
        if co == nil{
            
        }
        label.text = "hello from view 2"
        label.textColor = UIColor.red
        self.view.addSubview(label)
        
        
    }
    
    func name(param1:Int, param2:Int) -> Int {
        return 1
    }
    
    
}
