//
//  AfterUseSubscriber.swift
//  yonder
//
//  Created by Andre Pham on 17/7/2022.
//

import Foundation

protocol AfterUseSubscriber {
    
    func afterUse(_ item: ItemAbstract, owner: ActorAbstract, opposition: ActorAbstract)
    
}
