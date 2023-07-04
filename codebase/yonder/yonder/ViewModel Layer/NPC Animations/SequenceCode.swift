//
//  SequenceCode.swift
//  yonder
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation

enum SequenceCode: String, CaseIterable {
    case hit = "hit"
    case death = "death"
    case breathing = "breathing"
    case idle = "idle"
    case attack = "attack"
    
    // We don't ever use the "run" animation sequence, but if we ever want to, it's here (just uncomment)
    //case run = "run"
}
