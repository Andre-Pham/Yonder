//
//  ObservableArray.swift
//  yonder
//
//  Created by Andre Pham on 25/1/2022.
//

import Foundation
import Combine

class ObservableArray<T>: ObservableObject {

    @Published var array: [T] = []
    var cancellables = [AnyCancellable]()

    init(array: [T]) {
        self.array = array
    }
    
    func observeChildrenChanges<T: ObservableObject>() -> ObservableArray<T> {
        (self.array as! [T]).forEach({
            self.cancellables.append($0.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }))
        })
        
        return self as! ObservableArray<T>
    }
    
    func appendToArray(_ newElement: T) where T: ObservableObject {
        self.array.append(newElement)
        self.cancellables.append(newElement.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }))
    }

}
