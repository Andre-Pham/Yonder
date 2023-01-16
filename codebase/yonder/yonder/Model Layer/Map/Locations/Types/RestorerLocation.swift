//
//  RestorerLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class RestorerLocation: Location {
    
    private(set) var restorer: Restorer? = nil
    public let type: LocationType = .restorer
    
    override init() {
        super.init()
    }
    
    init(restorer: Restorer) {
        self.restorer = restorer
        super.init()
    }
    
    func initContent(using contentManager: ContentManager) {
        guard self.restorer == nil else {
            return
        }
        self.restorer = contentManager.generateRestorer(using: self.context)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case restorer
    }

    required init(dataObject: DataObject) {
        self.restorer = dataObject.getObjectOptional(Field.restorer.rawValue, type: Restorer.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.restorer.rawValue, value: self.restorer)
    }
    
}
