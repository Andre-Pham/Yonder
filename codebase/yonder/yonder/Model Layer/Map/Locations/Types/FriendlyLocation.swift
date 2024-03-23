//
//  FriendlyLocation.swift
//  yonder
//
//  Created by Andre Pham on 20/12/21.
//

import Foundation

class FriendlyLocation: Location, InteractorLocation {
    
    /// The friendly of the location - only generated when the player visits this location
    private var generatedFriendly: Friendly? = nil
    /// An accessor for the generated friendly - external classes should always assume any content it requires is already generated otherwise something has gone seriously wrong
    public var friendly: Friendly {
        assert(self.generatedFriendly != nil, "Content is being retrieved from a location before initContent method called")
        return self.generatedFriendly!
    }
    /// The location type - corresponds to class type but allows exhaustive switch cases and associated data
    public let type: LocationType = .friendly
    
    /// Initialises without any content - content will be generated during gameplay if the player travels here.
    override init() {
        super.init()
    }
    
    /// Initialises with content (content won't be generated and injected during gameplay).
    /// - Parameters:
    ///   - friendly: This location's friendly
    init(friendly: Friendly) {
        self.generatedFriendly = friendly
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case friendly
    }

    required init(dataObject: DataObject) {
        self.generatedFriendly = dataObject.getObjectOptional(Field.friendly.rawValue, type: Friendly.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.friendly.rawValue, value: self.generatedFriendly)
    }
    
    // MARK: - Functions
    
    /// Initialises any required content for the player to interact with. Only called if the player is travelling here.
    /// - Parameters:
    ///   - contentManager: The content manager to generate any required content for this location
    func initContent(using contentManager: ContentManager) {
        guard self.generatedFriendly == nil else {
            assertOutsideUnitTests(self.friendly.contentID != nil, "Pre-generated content missing content ID required")
            return
        }
        self.generatedFriendly = contentManager.generateFriendly(using: self.context)
    }
    
    func getInteractor() -> InteractorAbstract? {
        return self.generatedFriendly
    }
    
}
