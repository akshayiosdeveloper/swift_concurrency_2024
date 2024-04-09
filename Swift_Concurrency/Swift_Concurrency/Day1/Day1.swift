//
//  Day1.swift
//  Swift_Concurrency
//
//  Created by Akshay Kumar on 09/04/24.
//

import Foundation

class Day1 {
    func randomD6() -> Int {
        Int.random(in: 1...6)
    }
    //randomD6()
    
    func randowmD7() async -> Int {
        Int.random(in: 1...6)
    }
    
}
