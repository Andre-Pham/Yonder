//
//  BossLocation.swift
//  yonder
//
//  Created by Andre Pham on 24/12/21.
//

import Foundation

class BossLocation: Location, FoeLocation {
    
    /// The boss of the location - only generated when the player visits this location
    private var generatedBoss: Foe? = nil
    /// An accessor for the generated boss - external classes should always assume any content it requires is already generated otherwise something has gone seriously wrong
    public var foe: Foe {
        assert(self.generatedBoss != nil, "Content is being retrieved from a location before initContent method called")
        return self.generatedBoss!
    }
    /// The location type - corresponds to class type but allows exhaustive switch cases and associated data
    public let type: LocationType = .boss
    
    /// Initialises without any content - content will be generated during gameplay when the player travels here.
    override init() {
        super.init()
    }
    
    /// Initialises with content (content won't be generated and injected during gameplay).
    /// - Parameters:
    ///   - boss: This location's boss
    init(boss: Foe) {
        self.generatedBoss = boss
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case foe
    }

    required init(dataObject: DataObject) {
        self.generatedBoss = dataObject.getObjectOptional(Field.foe.rawValue, type: Foe.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.foe.rawValue, value: self.generatedBoss)
    }
    
    // MARK: - Functions
    
    /// Initialises any required content for the player to interact with. Only called if the player is travelling here.
    /// - Parameters:
    ///   - contentManager: The content manager to generate any required content for this location
    func initContent(using contentManager: ContentManager) {
        guard self.generatedBoss == nil else {
            assert(self.foe.contentID != nil, "Pre-generated content missing content ID required")
            return
        }
        self.generatedBoss = contentManager.generateBoss(using: self.context)
    }
    
}
