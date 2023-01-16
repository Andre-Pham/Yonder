//
//  HostileLocation.swift
//  yonder
//
//  Created by Andre Pham on 30/11/21.
//

import Foundation

class HostileLocation: Location, FoeLocation {
    
    private(set) var foe: Foe? = nil
    public let type: LocationType = .hostile
    
    override init() {
        super.init()
    }
    
    init(foe: Foe) {
        self.foe = foe
        super.init()
    }
    
    func initContent(using contentManager: ContentManager) {
        guard self.foe == nil else {
            return
        }
        self.foe = contentManager.generateHostile(using: self.context)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case foe
    }

    required init(dataObject: DataObject) {
        self.foe = dataObject.getObjectOptional(Field.foe.rawValue, type: Foe.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.foe.rawValue, value: self.foe)
    }
    
}
