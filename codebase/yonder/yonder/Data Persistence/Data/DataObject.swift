//
//  DataObject.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation
import SwiftyJSON
import SwiftUI

/// Refer to DummyClasses.swift for usage example.
class DataObject {
    
    // MARK: - Properties
    
    /// NOT IMPLEMENTED YET - A dictionary of class names that may be stored and have been since refactored to a new name
    private static let legacyClassNames: [String: String] = [:]
    /// The JSON key that corresponds to the object name of the data object
    private let objectField = "object"
    /// The name of the object (class) this instance represents (the value to objectField)
    private(set) var objectName = String()
    /// The JSON this wrapper represents
    private var json = JSON()
    /// The Data representation of this
    var rawData: Data {
        do {
            return try self.json.rawData()
        } catch {
            return Data()
        }
    }
    /// The date formatter used for adding and retrieving dates
    private var dateFormatter: DateFormatter {
        let result = DateFormatter()
        result.locale = Locale(identifier: "en_US_POSIX")
        result.timeZone = TimeZone(secondsFromGMT: 0)
        result.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return result
    }
    
    // MARK: - Initialisers
    
    init(_ object: Storable) {
        self.add(key: self.objectField, value: object.className)
        self.objectName = object.className
    }
    
    init(rawString: String) {
        self.json = JSON(parseJSON: rawString)
        self.objectName = self.get(self.objectField)
    }
    
    init(data: Data) {
        do {
            try self.json = JSON(data: data)
        } catch {
            print("JSON data could not be instantiated into a DataObject")
        }
        self.objectName = self.get(self.objectField)
    }
    
    private init(json: JSON) {
        self.json = json
        self.objectName = self.get(self.objectField)
    }
    
    // MARK: - Data addition methods
    // While generics can be used here, being explicit with data types allows compiler checking before runtime
    // Generics allows anything to be valid, causing crashes at runtime
    
    @discardableResult
    func add(key: String, value: String) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: String?) -> Self {
        self.json[key] = JSON(value ?? JSON.null)
        return self
    }
    
    @discardableResult
    func add(key: String, value: [String]) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: [String?]) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: Int) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: Int?) -> Self {
        self.json[key] = JSON(value ?? JSON.null)
        return self
    }
    
    @discardableResult
    func add(key: String, value: [Int]) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: [Int?]) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: Double) -> Self {
        self.json[key] = JSON(Decimal(value))
        return self
    }
    
    @discardableResult
    func add(key: String, value: Double?) -> Self {
        if let value {
            self.json[key] = JSON(Decimal(value))
        } else {
            self.json[key] = JSON.null
        }
        return self
    }
    
    @discardableResult
    func add(key: String, value: [Double]) -> Self {
        self.json[key] = JSON(value.map({ Double($0) }))
        return self
    }
    
    @discardableResult
    func add(key: String, value: [Double?]) -> Self {
        self.json[key] = JSON(value.map({ $0 == nil ? nil : Double($0!) }))
        return self
    }
    
    @discardableResult
    func add(key: String, value: Bool) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: Bool?) -> Self {
        self.json[key] = JSON(value ?? JSON.null)
        return self
    }
    
    @discardableResult
    func add(key: String, value: [Bool]) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: [Bool?]) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: Date) -> Self {
        return self.add(key: key, value: self.dateFormatter.string(from: value))
    }
    
    @discardableResult
    func add(key: String, value: Date?) -> Self {
        if let value {
            self.add(key: key, value: value)
        } else {
            self.json[key] = JSON.null
        }
        return self
    }
    
    @discardableResult
    func add(key: String, value: [Date]) -> Self {
        let dateStrings: [String] = value.map({ self.dateFormatter.string(from: $0) })
        return self.add(key: key, value: dateStrings)
    }
    
    @discardableResult
    func add(key: String, value: [Date?]) -> Self {
        let dateStrings: [String?] = value.map({
            if let date = $0 {
                return self.dateFormatter.string(from: date)
            } else {
                return nil
            }
        })
        return self.add(key: key, value: dateStrings)
    }
    
    @discardableResult
    func add<T: Storable>(key: String, value: T) -> Self {
        self.json[key] = value.toDataObject().json
        return self
    }
    
    @discardableResult
    func add<T: Storable>(key: String, value: T?) -> Self {
        self.json[key] = value?.toDataObject().json ?? JSON.null
        return self
    }
    
    @discardableResult
    func add<T: Storable>(key: String, value: [T]) -> Self {
        self.json[key] = JSON(value.map { $0.toDataObject().json })
        return self
    }
    
    @discardableResult
    func add<T: Storable>(key: String, value: [T?]) -> Self {
        self.json[key] = JSON(value.map { $0?.toDataObject().json ?? JSON.null })
        return self
    }
    
    // MARK: - Data retrieval methods
    
    func get(_ key: String, onFail: String = "") -> String {
        let retrieval = self.json[key].string
        assert(retrieval != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        return retrieval ?? onFail
    }
    
    func get(_ key: String) -> String? {
        return self.json[key].string
    }
    
    func get(_ key: String) -> [String] {
        let array = self.json[key].array
        assert(array != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        let valueArray = (array ?? []).map { $0.stringValue }
        assert(array?.count == valueArray.count, "JSON array came with \(array?.count ?? -1) elements, but only \(valueArray.count) could be restored")
        return valueArray
    }
    
    func get(_ key: String) -> [String?] {
        let array = self.json[key].array
        assert(array != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        let valueArray = (array ?? []).map { $0.string }
        return valueArray
    }
    
    func get(_ key: String, onFail: Int = 0) -> Int {
        let retrieval = self.json[key].int
        assert(retrieval != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        return retrieval ?? onFail
    }
    
    func get(_ key: String) -> Int? {
        return self.json[key].int
    }
    
    func get(_ key: String) -> [Int] {
        let array = self.json[key].array
        assert(array != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        let valueArray = (array ?? []).map { $0.intValue }
        assert(array?.count == valueArray.count, "JSON array came with \(array?.count ?? -1) elements, but only \(valueArray.count) could be restored")
        return valueArray
    }
    
    func get(_ key: String) -> [Int?] {
        let array = self.json[key].array
        assert(array != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        let valueArray = (array ?? []).map { $0.int }
        return valueArray
    }
    
    func get(_ key: String, onFail: Double = 0.0) -> Double {
        let retrieval = self.json[key].double
        assert(retrieval != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        return retrieval ?? onFail
    }
    
    func get(_ key: String) -> Double? {
        return self.json[key].double
    }
    
    func get(_ key: String) -> [Double] {
        let array = self.json[key].array
        assert(array != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        let valueArray = (array ?? []).map { $0.doubleValue }
        assert(array?.count == valueArray.count, "JSON array came with \(array?.count ?? -1) elements, but only \(valueArray.count) could be restored")
        return valueArray
    }
    
    func get(_ key: String) -> [Double?] {
        let array = self.json[key].array
        assert(array != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        let valueArray = (array ?? []).map { $0.double }
        return valueArray
    }
    
    func get(_ key: String, onFail: Bool) -> Bool {
        let retrieval = self.json[key].bool
        assert(retrieval != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        return retrieval ?? onFail
    }
    
    func get(_ key: String) -> Bool? {
        return self.json[key].bool
    }
    
    func get(_ key: String) -> [Bool] {
        let array = self.json[key].array
        assert(array != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        let valueArray = (array ?? []).map { $0.boolValue }
        assert(array?.count == valueArray.count, "JSON array came with \(array?.count ?? -1) elements, but only \(valueArray.count) could be restored")
        return valueArray
    }
    
    func get(_ key: String) -> [Bool?] {
        let array = self.json[key].array
        assert(array != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        let valueArray = (array ?? []).map { $0.bool }
        return valueArray
    }
    
    func get(_ key: String, onFail: Date = Date()) -> Date {
        let dateString: String = self.get(key, onFail: "")
        if dateString.isEmpty {
            assertionFailure("Failed to restore attribute '\(key)' to object \(self.objectName)")
            return onFail
        }
        let date = self.dateFormatter.date(from: dateString)
        assert(date != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        return date ?? onFail
    }
    
    func get(_ key: String) -> Date? {
        let dateString: String? = self.get(key)
        guard dateString != nil else {
            return nil
        }
        return self.dateFormatter.date(from: dateString!)
    }
    
    func get(_ key: String) -> [Date] {
        let array = self.json[key].array
        assert(array != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        let stringArray = (array ?? []).map { $0.stringValue }
        assert(array?.count == stringArray.count, "JSON array came with \(array?.count ?? -1) elements, but only \(stringArray.count) could be restored")
        let valueArray = stringArray.compactMap({ self.dateFormatter.date(from: $0) })
        assert(valueArray.count == stringArray.count, "JSON array came with \(stringArray.count) elements, but only \(valueArray.count) could be restored as dates")
        return valueArray
    }
    
    func get(_ key: String) -> [Date?] {
        let array = self.json[key].array
        assert(array != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        let stringArray = (array ?? []).map { $0.string }
        let valueArray = stringArray.map({
            if let stringDate = $0 {
                return self.dateFormatter.date(from: stringDate)
            } else {
                return nil
            }
        })
        return valueArray
    }
    
    func getObject<T>(_ key: String, type: T.Type) -> T where T: Storable {
        return DataObject(json: JSON(self.json[key].object)).restore(type)
    }
    
    func getObjectOptional<T>(_ key: String, type: T.Type) -> T? where T: Storable {
        let json = self.json[key]
        if json == JSON.null { return nil }
        return DataObject(json: JSON(json.object)).restoreOptional(type)
    }
    
    func getObjectArray<T>(_ key: String, type: T.Type) -> [T] where T: Storable {
        let array = self.json[key].array
        assert(array != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        return ((array ?? []).map { DataObject(json: $0) }).restoreArray(type)
    }
    
    // MARK: - String export
    
    func toRawString() -> String {
        return self.json.rawString()!
    }
    
    // MARK: - Storable export
    
    func restore<T>(_ type: T.Type) -> T where T: Storable {
        let parse = self.parse()
        guard let object = parse as? T else {
            fatalError("Object \(type.self) could not be restored - some class within its inheritance tree likely forgot to add a variable within the toDataObject call")
        }
        return object
    }
    
    func restoreOptional<T>(_ type: T.Type) -> T? where T: Storable {
        let parse = self.parse() as? T
        assert(parse != nil, "Object \(type.self) failed to be restored - some class within its inheritance tree likely forgot to add a variable within the toDataObject call")
        return parse
    }
    
    private func parse() -> Storable? {
        if let className = self.json["object"].string {
            var activeClassName = className
            while Self.legacyClassNames[activeClassName] != nil {
                activeClassName = Self.legacyClassNames[activeClassName]!
            }
            let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            guard let type = NSClassFromString("\(nameSpace).\(activeClassName)") as? Storable.Type else {
                assertionFailure("Class \(nameSpace).\(activeClassName) does not exist but is trying to be restored")
                return nil
            }
            return type.init(dataObject: DataObject(json: self.json))
        }
        return nil
    }
    
}

extension Array where Element: DataObject {
    
    fileprivate func restoreArray<T>(_ type: T.Type) -> [T] where T: Storable {
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
