//
//  DataObject.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation
import SwiftyJSON

/// Refer to DummyClasses.swift for usage example.
class DataObject {
    
    // MARK: - Properties
    
    private static let legacyClassNames: [String: String] = [:]
    private let objectField = "object"
    
    private var objectName = String() // For debugging
    private var json = JSON()
    
    // MARK: - Initialisers
    
    init(_ object: Storable) {
        self.add(key: self.objectField, value: object.className)
        self.objectName = object.className
    }
    
    init(rawString: String) {
        self.json = JSON(parseJSON: rawString)
        self.objectName = self.get(self.objectField)
    }
    
    private init(json: JSON) {
        self.json = json
        self.objectName = self.get(self.objectField)
    }
    
    // MARK: - Data addition methods
    
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
    func add(key: String, value: Double) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: Double?) -> Self {
        self.json[key] = JSON(value ?? JSON.null)
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
    func add<T: Storable>(key: String, value: T) -> Self {
        self.json[key] = value.toDataObject().json
        return self
    }
    
    @discardableResult
    func add<T: Storable>(key: String, value: [T]) -> Self {
        self.json[key] = JSON(value.map { $0.toDataObject().json })
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
    
    func get(_ key: String, onFail: Int = 0) -> Int {
        let retrieval = self.json[key].int
        assert(retrieval != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        return retrieval ?? onFail
    }
    
    func get(_ key: String) -> Int? {
        return self.json[key].int
    }
    
    func get(_ key: String, onFail: Double = 0.0) -> Double {
        let retrieval = self.json[key].double
        assert(retrieval != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        return retrieval ?? onFail
    }
    
    func get(_ key: String) -> Double? {
        return self.json[key].double
    }
    
    func get(_ key: String, onFail: Bool) -> Bool {
        let retrieval = self.json[key].bool
        assert(retrieval != nil, "Failed to restore attribute '\(key)' to object '\(self.objectName)'")
        return retrieval ?? onFail
    }
    
    func get(_ key: String) -> Bool? {
        return self.json[key].bool
    }
    
    func getObject<T>(_ key: String, type: T.Type) -> T where T: Storable {
        return DataObject(json: JSON(self.json[key].object)).restore(type)
    }
    
    func getObjectOptional<T>(_ key: String, type: T.Type) -> T? where T: Storable {
        return DataObject(json: JSON(self.json[key].object)).restoreOptional(type)
    }
    
    func getObjectArray<T>(_ key: String, type: T.Type) -> [T] where T: Storable {
        return ((self.json[key].array ?? []).map { DataObject(json: $0) }).restoreArray(type)
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
            return (NSClassFromString("\(nameSpace).\(activeClassName)") as! Storable.Type).init(dataObject: DataObject(json: self.json))
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
