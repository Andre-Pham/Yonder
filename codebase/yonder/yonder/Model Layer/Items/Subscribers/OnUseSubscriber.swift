//
//  OnUseSubscriber.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import Foundation

protocol OnUseSubscriber {
    
    func onUse(_ item: ItemAbstract, owner: ActorAbstract, opposition: ActorAbstract)
    
}
