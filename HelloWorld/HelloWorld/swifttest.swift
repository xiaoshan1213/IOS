//
//  swifttest.swift
//  HelloWorld
//
//  Created by Sam Ma on 5/15/17.
//  Copyright © 2017 Sam Ma. All rights reserved.
//

import Foundation

class test: proto1{
    
    internal func testproto(_: Int) -> Int {
        return 1
    }

    func test(_ param1:Int, from param2:Int, _: Int = 3) -> Int {
        return 1
    }
    
    func main() {
        test(1, from: 2, 3)
        var names:[String] = ["sam", "jack"]
        names.sort { (s1, s2) -> Bool in
            s1>s2
        }
        names.sorted(by:{$0>$1})
        let reverseNames = names.sorted{$0>$1}
        debugPrint(reverseNames)
        
        func testClosure(closure:() -> Void){
            
        }
        
        //trailing closure test
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        let strings = numbers.map { (number) -> String in
            var number = number
            var output = ""
            repeat{
                output = digitNames[number%10]! + output
                number /= 10
            }while number > 0
            return output
        }
        
        DispatchQueue.global().async { 
            //queue
        }
        
    }
}

protocol proto1 {
    func testproto(_: Int) -> Int
}




