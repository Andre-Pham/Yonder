//
//  FriendlyLocation.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation

class FriendlyLocation: Location {
    
    private(set) var friendly: Friendly? = nil
    public let type: LocationType = .friendly
    
    override init() {
        super.init()
    }
    
    init(friendly: Friendly) {
        self.friendly = friendly
        super.init()
    }
    
    func initContent(using contentManager: ContentManager) {
        guard self.friendly == nil else {
            return
        }
        self.friendly = contentManager.generateFriendly(using: self.context)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case friendly
    }

    required init(dataObject: DataObject) {
        self.friendly = dataObject.getObjectOptional(Field.friendly.rawValue, type: Friendly.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.friendly.rawValue, value: self.friendly)
    }
    
}
