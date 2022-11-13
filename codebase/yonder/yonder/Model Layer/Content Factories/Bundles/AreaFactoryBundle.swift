//
//  AreaFactoryBundle.swift
//  yonder
//
//  Created by Andre Pham on 10/11/2022.
//

import Foundation

class AreaFactoryBundle {
    
    public let interactorFactories: InteractorFactoryBundle
    public let foeFactory: FoeFactory
    public let challengeHostileFactory: FoeFactory
    
    init(interactors: InteractorFactoryBundle, foes: FoeFactory, challengeHostiles: FoeFactory) {
        self.interactorFactories = interactors
        self.foeFactory = foes
        self.challengeHostileFactory = challengeHostiles
    }
    
}
