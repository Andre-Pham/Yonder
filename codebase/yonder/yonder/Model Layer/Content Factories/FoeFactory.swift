//
//  FoeFactory.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class FoeFactory {
    
    private let stage: Int
    private let areaTags: AreaProfileTagAllocation
    private let foeProfileBucket: FoeProfileBucket
    private var foeSupply = [Foe]()
    
    init(stage: Int, areaTags: AreaProfileTagAllocation, profileBucket: FoeProfileBucket) {
        self.stage = stage
        self.areaTags = areaTags
        self.foeProfileBucket = profileBucket
    }
    
    private func buildFoes(stage: Int, tags: AreaProfileTagAllocation) {
        
        // I'll need to retrieve profiles that match the area profile tag and foe type
        // I'll also need to generate appropriate loot based on the stage and area profile tag
        
        var foes = [Foe]()
        foes.populate(count: 20) {
            Foes.newRegularFoe(profile: self.foeProfileBucket.grabProfile(areaTag: tags.getTag(), foeTag: .regular), stage: stage, loot: <#T##LootOptions#>)
        }
        foes.populate(count: 5) {
            Foes.newRegularTankFoe(profile: <#T##FoeProfile#>, stage: <#T##Int#>, loot: <#T##LootOptions#>)
        }
        // repeat for all types of foes
        
        // shuffle foes
        
        self.foeSupply.append(contentsOf: foes)
    }
    
    func deliver() -> Foe {
        guard !self.foeSupply.isEmpty else {
            self.buildFoes(stage: self.stage, tags: self.areaTags)
        }
        return self.foeSupply.popLast()!
    }
    
    func deliver(count: Int) -> [Foe] {
        guard self.foeSupply.count >= count else {
            self.buildFoes(stage: self.stage, tags: self.areaTags)
        }
        return self.foeSupply.dropLast(count)
    }
    
}
