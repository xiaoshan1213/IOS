//
//  Story.swift
//  Destini
//
//  Created by Sam Ma on 10/25/17.
//  Copyright © 2017 London App Brewery. All rights reserved.
//

import Foundation

class Story {
    
    var storyId : Int
    var story : String
    var ans1 : String
    var ans2 : String
    
    init(id : Int, story : String, ans1 : String, ans2 : String) {
        
        self.storyId = id
        self.story = story
        self.ans1 = ans1
        self.ans2 = ans2
    }
}
