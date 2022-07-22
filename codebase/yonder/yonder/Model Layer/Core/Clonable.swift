//
//  Clonable.swift
//  yonder
//
//  Created by Andre Pham on 20/3/2022.
//

import Foundation

protocol Clonable {

    init(_ original: Self)
    
}
extension Clonable {
    
    func clone() -> Self {
        return type(of: self).init(self)
    }
    
}
extension Array where Element: Clonable {
    
    func clone() -> Array {
        var clonedArray = Array<Element>()
        for element in self {
            clonedArray.append(element.clone())
        }
        return clonedArray
    }
    
}
extension Dictionary where Value: Clonable {
    
    func clone() -> Dictionary {
        var clonedDictionary = Dictionary<Key, Value>()
        for pair in self {
            clonedDictionary[pair.key] = pair.value.clone()
        }
        return clonedDictionary
    }
    
}
