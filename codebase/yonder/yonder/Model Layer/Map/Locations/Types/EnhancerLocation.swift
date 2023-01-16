//
//  EnhancerLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class EnhancerLocation: Location {
    
    private(set) var enhancer: Enhancer? = nil
    public let type: LocationType = .enhancer
    
    override init() {
        super.init()
    }
    
    init(enhancer: Enhancer) {
        self.enhancer = enhancer
        super.init()
    }
    
    func initContent(using contentManager: ContentManager) {
        guard self.enhancer == nil else {
            return
        }
        self.enhancer = contentManager.generateEnhancer(using: self.context)
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case enhancer
    }

    required init(dataObject: DataObject) {
        self.enhancer = dataObject.getObjectOptional(Field.enhancer.rawValue, type: Enhancer.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.enhancer.rawValue, value: self.enhancer)
    }
    
}
