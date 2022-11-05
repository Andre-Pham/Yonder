//
//  DataObjectArray.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

extension Array where Element: DataObject {
    
    func restoreArray<T>(_ type: T.Type) -> [T] where T: Storable {
        var restored = Array<T>()
        for element in self {
            guard let restoredElement = element.restoreOptional(T.self) else {
                assertionFailure("DataObject of type \(String(describing: T.self)) could not be restored")
                continue
            }
            restored.append(restoredElement)
        }
        return restored
    }
    
}
