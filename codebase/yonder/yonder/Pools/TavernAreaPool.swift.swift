//
//  TavernAreaPool.swift.swift
//  yonder
//
//  Created by Andre Pham on 23/12/21.
//

import Foundation

class TavernAreaPool {
    
    private(set) var tavernAreas: [TavernArea]
    
    init(tavernAreas: [TavernArea]) {
        self.tavernAreas = tavernAreas
    }
    
    // This doesn't remove a tavern area because each territory has a single tavern, hence doesn't need to re-grab, hence there's no chance of duplicate tavern areas
    func grabTavernArea() -> TavernArea? {
        return self.tavernAreas.randomElement()
    }
    
}
