//
//  Stopwatch.swift
//  Stopwatch-App
//
//  Created by Afiq Ramli on 26/06/2018.
//  Copyright © 2018 Afiq Ramli. All rights reserved.
//

import Foundation

class Stopwatch: NSObject {
    var counter: Double
    var timer: Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
}
