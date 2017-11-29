//
//  GenerateInstances.swift
//  DynamicPrototypes
//
//  Created by Aloc SP08608 on 29/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation

class GenerateInstances {
    
    static func generateHiScore(quantityInstances : UInt) -> [HiScore] {
        var result = [HiScore]()
        
        for i in 1...quantityInstances {
            result.append(HiScore(name: "Name \(i)", rating: (Int(i % 5) + 1)))
        }
        
        return result
    }
    
}
