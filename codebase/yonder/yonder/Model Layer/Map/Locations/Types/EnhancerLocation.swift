//
//  EnhancerLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class EnhancerLocation: Location {
    
    /// The enhancer of the location - only generated when the player visits this location
    private var generatedEnhancer: Enhancer? = nil
    /// An accessor for the generated enhancer - external classes should always assume any content it requires is already generated otherwise something has gone seriously wrong
    public var enhancer: Enhancer {
        assert(self.generatedEnhancer != nil, "Content is being retrieved from a location before initContent method called")
        return self.generatedEnhancer!
    }
    /// The location type - corresponds to class type but allows exhaustive switch cases and associated data
    public let type: LocationType = .enhancer
    
    /// Initialises without any content - content will be generated during gameplay if the player travels here.
    override init() {
        super.init()
    }
    
    /// Initialises with content (content won't be generated and injected during gameplay).
    /// - Parameters:
    ///   - enhancer: This location's enhancer
    init(enhancer: Enhancer) {
        self.generatedEnhancer = enhancer
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case enhancer
    }

    required init(dataObject: DataObject) {
        self.generatedEnhancer = dataObject.getObjectOptional(Field.enhancer.rawValue, type: Enhancer.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.enhancer.rawValue, value: self.generatedEnhancer)
    }
    
    // MARK: - Functions
    
    /// Initialises any required content for the player to interact with. Only called if the player is travelling here.
    /// - Parameters:
    ///   - contentManager: The content manager to generate any required content for this location
    func initContent(using contentManager: ContentManager) {
        guard self.generatedEnhancer == nil else {
            return
        }
        self.generatedEnhancer = contentManager.generateEnhancer(using: self.context)
    }
    
}
