//
//  StorableArray.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

extension Array where Element: Storable {
    
    func toDataObject() -> DataObject {
        var objects = Array<DataObject>()
        for element in self {
            objects.append(element.toDataObject())
        }
        return DataObject(dataObjects: objects)
    }
    
}
