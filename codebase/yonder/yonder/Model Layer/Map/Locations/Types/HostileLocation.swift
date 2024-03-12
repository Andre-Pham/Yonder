//
//  HostileLocation.swift
//  yonder
//
//  Created by Andre Pham on 30/11/21.
//

import Foundation

class HostileLocation: Location, FoeLocation {
    
    /// The foe of the location - only generated when the player visits this location
    private var generatedFoe: Foe? = nil
    /// An accessor for the generated foe - external classes should always assume any content it requires is already generated otherwise something has gone seriously wrong
    public var foe: Foe {
        assert(self.generatedFoe != nil, "Content is being retrieved from a location before initContent method called")
        return self.generatedFoe!
    }
    /// The location type - corresponds to class type but allows exhaustive switch cases and associated data
    public let type: LocationType = .hostile
    
    /// Initialises without any content - content will be generated during gameplay if the player travels here.
    override init() {
        super.init()
    }
    
    /// Initialises with content (content won't be generated and injected during gameplay).
    /// - Parameters:
    ///   - foe: This location's foe
    init(foe: Foe) {
        self.generatedFoe = foe
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case foe
    }

    required init(dataObject: DataObject) {
        self.generatedFoe = dataObject.getObjectOptional(Field.foe.rawValue, type: Foe.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.foe.rawValue, value: self.generatedFoe)
    }
    
    // MARK: - Functions
    
    /// Initialises any required content for the player to interact with. Only called if the player is travelling here.
    /// - Parameters:
    ///   - contentManager: The content manager to generate any required content for this location
    func initContent(using contentManager: ContentManager) {
        guard self.generatedFoe == nil else {
            assert(self.foe.contentID != nil, "Pre-generated content missing content ID required")
            return
        }
        self.generatedFoe = contentManager.generateHostile(using: self.context)
    }
    
}
