//
//  Storable.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

protocol Storable {
    
    func toDataObject() -> DataObject
    init(dataObject: DataObject)
    
}
extension Storable {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
}
