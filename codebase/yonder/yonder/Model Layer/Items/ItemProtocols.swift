//
//  ItemProtocols.swift
//  yonder
//
//  Created by Andre Pham on 18/11/21.
//

import Foundation

protocol Usable {
    
    func use(owner: ActorAbstract, opposition: ActorAbstract)
    
}

protocol SharedID {
    
    static var sharedID: UUID { get }
    
}
extension SharedID {
    
    func getSharedID() -> UUID {
        return type(of: self).sharedID
    }
    
}
