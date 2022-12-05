//
//  LocalDatabaseSession.swift
//  yonder
//
//  Created by Andre Pham on 4/12/2022.
//

import Foundation

class LocalDatabaseSession {
    
    static let instance = LocalDatabaseSession()
    
    private let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private var url: URL {
        URL(fileURLWithPath: "gamedata", relativeTo: self.directoryURL).appendingPathExtension("json")
    }
    
    private init() { }
    
    func write(_ storable: Storable) -> Bool {
        let dataObject = storable.toDataObject()
        return self.write(dataObject)
    }
    
    func write(_ dataObject: DataObject) -> Bool {
        do {
            let data = dataObject.rawData
            try data.write(to: self.url)
            return true
        } catch {
            return false
        }
    }
    
    func read<T: Storable>() -> T? {
        if let data = try? Data(contentsOf: self.url) {
            let dataObject = DataObject(data: data)
            return dataObject.restore(T.self)
        }
        return nil
    }
    
}
