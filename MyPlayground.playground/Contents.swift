//: Playground - noun: a place where people can play

import UIKit

func permutate(string1: String, string2: String) -> Int {
    
    let String1 = Array(string1.characters)
    let String2 = Array(string2.characters)
    var count = 0
    
    for x in String1 {
        
        if String2.contains(x) {
        
        count += 1
            
            if String1.count == count {
                
                return 0
            }
        }
    }
    
    return 1
}

permutate(string1: "god", string2: "dog")
