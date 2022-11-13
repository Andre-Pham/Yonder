//
//  InteractorFactoryBundle.swift
//  yonder
//
//  Created by Andre Pham on 13/11/2022.
//

import Foundation

class InteractorFactoryBundle {
    
    public let shopKeeperFactory: ShopKeeperFactory
    public let enhancerFactory: EnhancerFactory
    public let restorerFactory: RestorerFactory
    public let friendlyFactory: FriendlyFactory
    
    init(shopKeeperFactory: ShopKeeperFactory, enhancerFactory: EnhancerFactory, restorerFactory: RestorerFactory, friendlyFactory: FriendlyFactory) {
        self.shopKeeperFactory = shopKeeperFactory
        self.enhancerFactory = enhancerFactory
        self.restorerFactory = restorerFactory
        self.friendlyFactory = friendlyFactory
    }
    
}
