//
//  Record.swift
//  yonder
//
//  Created by Andre Pham on 3/1/2023.
//

import Foundation

class Record<T: Storable> {
    
    public let metadata: Metadata
    public let data: T
    
    init(id: String = UUID().uuidString, data: T) {
        self.metadata = Metadata(objectName: data.className, id: id)
        self.data = data
    }
    
}
