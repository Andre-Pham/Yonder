//
//  BossLocation.swift
//  yonder
//
//  Created by Andre Pham on 24/12/21.
//

import Foundation

class BossLocation: Location, FoeLocation {
    
    /// The boss of this location
    private(set) var foe: Foe
    /// The location type - corresponds to class type but allows exhaustive switch cases and associated data
    public let type: LocationType = .boss
    
    /// Initialises with content (content won't be generated and injected during gameplay).
    /// - Parameters:
    ///   - boss: This location's boss
    init(boss: Foe) {
        self.foe = boss
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case foe
    }

    required init(dataObject: DataObject) {
        self.foe = dataObject.getObject(Field.foe.rawValue, type: Foe.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.foe.rawValue, value: self.foe)
    }
    
    // MARK: - Functions
    
    /// Initialises any required content for the player to interact with. Only called if the player is travelling here.
    /// - Parameters:
    ///   - contentManager: The content manager to generate any required content for this location
    func initContent(using contentManager: ContentManager) {
        // No content to initialise - bosses are generated during the game's creation
    }
    
}
