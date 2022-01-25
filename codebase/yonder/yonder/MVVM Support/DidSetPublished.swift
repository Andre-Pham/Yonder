//
//  DidSetPublished.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation
import Combine

/// Publishes whenever a value is changed.
///
/// Essentially the @Published property wrapper, except it publishes after the value has been set (through CurrentValueSubject), rather how @Published behaves, which publishes before the value has been set (which emulates PassThroughSubject).
@propertyWrapper
class DidSetPublished<Value> {
    private var val: Value
    private let subject: CurrentValueSubject<Value, Never>

    init(wrappedValue value: Value) {
        val = value
        subject = CurrentValueSubject(value)
        wrappedValue = value
    }

    var wrappedValue: Value {
        set {
            val = newValue
            subject.send(val)
        }
        get { val }
    }

    public var projectedValue: CurrentValueSubject<Value, Never> {
      get { subject }
    }
}
