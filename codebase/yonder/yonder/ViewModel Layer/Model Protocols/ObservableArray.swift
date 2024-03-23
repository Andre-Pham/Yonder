//
//  ObservableArray.swift
//  yonder
//
//  Created by Andre Pham on 25/1/2022.
//

import Foundation
import Combine

/// An observed array that also observes changes in its elements.
///
/// `@StateObject var firstCar = Car("red")`
/// `@StateObject var secondCar = Car("blue")`
///  Is equivalent to...
/// `@StateObject var cars: ObservableArray<Car> = ObservableArray(array: [Car("red"), Car("blue")]).observeChildrenChanges()`
class ObservableArray<T: ObservableObject>: ObservableObject {

    @Published var array: [T] = []
    var count: Int {
        return self.array.count
    }
    var cancellables = [AnyCancellable]()

    init(array: [T]) {
        self.array = array
    }
    
    subscript(index: Int) -> T {
        return self.array[index%self.array.count]
    }
    
    func observeChildrenChanges() -> ObservableArray<T> {
        self.array.forEach({
            self.cancellables.append($0.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }))
        })
        
        return self
    }
    
    func append(_ newElement: T) {
        self.array.append(newElement)
        self.cancellables.append(newElement.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() }))
    }

}
