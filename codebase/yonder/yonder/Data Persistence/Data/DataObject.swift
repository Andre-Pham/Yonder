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
    
    init(dataObjects: [DataObject]) {
        self.json = JSON(dataObjects.map { $0.json })
    }
    
    init(rawString: String) {
        self.json = JSON(parseJSON: rawString)
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
    func add(key: String, value: DataObject) -> Self {
        self.json[key] = value.json
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
    
    func getObjectArray(_ key: String) -> [DataObject] {
        return (self.json[key].array ?? []).map { DataObject(json: $0) }
    }
    
    func getObject(_ key: String) -> DataObject {
        return DataObject(json: JSON(self.json[key].object))
    }
    
    func restore<T>(_ type: T.Type) -> T where T: Storable {
        return self.parse() as! T
    }
    
    func restoreOptional<T>(_ type: T.Type) -> T? where T: Storable {
        return self.parse() as? T
    }
    
    func toRawString() -> String {
        return self.json.rawString()!
    }
    
    private func parse() -> Storable? {
        if let className = self.json["object"].string {
            var activeClassName = className
            while Self.legacyClassNames[activeClassName] != nil {
                activeClassName = Self.legacyClassNames[activeClassName]!
            }
            let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            return (NSClassFromString("\(nameSpace).\(activeClassName)") as! Storable.Type).init(dataObject: DataObject(json: json))
        }
        return nil
    }
    
}
