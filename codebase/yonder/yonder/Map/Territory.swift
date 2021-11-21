//
//  Territory.swift
//  yonder
//
//  Created by Andre Pham on 21/11/21.
//

import Foundation

class Territory {
    
    private(set) var area: Area
    private(set) var tavernArea: TavernArea
    
    init(area: Area, followingTavernArea: TavernArea) {
        self.area = area
        self.tavernArea = followingTavernArea
    }
    
}
