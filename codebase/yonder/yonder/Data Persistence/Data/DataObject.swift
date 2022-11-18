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
    
    private static let legacyClassNames: [String: String] = [:]
    
    private var json = JSON()
    
    init(className: String) {
        self.add(key: "object", value: className)
    }
    
    init(rawString: String) {
        self.json = JSON(parseJSON: rawString)
    }
    
    fileprivate init(dataObjects: [DataObject]) {
        self.json = JSON(dataObjects.map { $0.json })
    }
    
    fileprivate init(json: JSON) {
        self.json = json
    }
    
    @discardableResult
    func add(key: String, value: String) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: Int) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: Double) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: Bool) -> Self {
        self.json[key] = JSON(value)
        return self
    }
    
    @discardableResult
    func add(key: String, value: Storable) -> Self {
        self.json[key] = value.toDataObject().json
        return self
    }
    
    @discardableResult
    func add<T: Storable>(key: String, value: [T]) -> Self {
        self.json[key] = value.toDataObject().json
        return self
    }
    
    func get(_ key: String, onFail: String = "") -> String {
        return self.json[key].string ?? onFail
    }
    
    func get(_ key: String, onFail: Int = 0) -> Int {
        return self.json[key].int ?? onFail
    }
    
    func get(_ key: String, onFail: Double = 0.0) -> Double {
        return self.json[key].double ?? onFail
    }
    
    func get(_ key: String, onFail: Bool) -> Bool {
        return self.json[key].bool ?? onFail
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
    
    func toRawString() -> String {
        return self.json.rawString()!
    }
    
    func restore<T>(_ type: T.Type) -> T where T: Storable {
        return self.parse() as! T
    }
    
    func restoreOptional<T>(_ type: T.Type) -> T? where T: Storable {
        return self.parse() as? T
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

extension Array where Element: Storable {
    
    fileprivate func toDataObject() -> DataObject {
        var objects = Array<DataObject>()
        for element in self {
            objects.append(element.toDataObject())
        }
        return DataObject(dataObjects: objects)
    }
    
}
