//
//  NoMap.swift
//  yonder
//
//  Created by Andre Pham on 10/12/2022.
//

import Foundation

class NoMap: Map {
    
    override init() {
        super.init()
    }
    
    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }
    
}
