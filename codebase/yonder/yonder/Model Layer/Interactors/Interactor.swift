//
//  Interactor.swift
//  yonder
//
//  Created by Andre Pham on 2/12/21.
//

import Foundation

class InteractorAbstract: Named, Described {
    
    public let name: String
    public let description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
}
