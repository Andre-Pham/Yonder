//
//  WeaponProfileTagAllocation.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class WeaponProfileTagAllocation {
    
    public let tagsCode: String
    
    init(tags: [WeaponProfileTag]) {
        self.tagsCode = tags.map({ $0.rawValue }).sorted(by: { $0 < $1 }).joined(separator: ".")
    }
    
}
