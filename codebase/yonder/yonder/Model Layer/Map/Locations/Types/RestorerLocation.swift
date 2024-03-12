//
//  RestorerLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class RestorerLocation: Location, InteractorLocation {
    
    /// The restorer of the location - only generated when the player visits this location
    private var generatedRestorer: Restorer? = nil
    /// An accessor for the generated restorer - external classes should always assume any content it requires is already generated otherwise something has gone seriously wrong
    public var restorer: Restorer {
        assert(self.generatedRestorer != nil, "Content is being retrieved from a location before initContent method called")
        return self.generatedRestorer!
    }
    /// The location type - corresponds to class type but allows exhaustive switch cases and associated data
    public let type: LocationType = .restorer
    
    /// Initialises without any content - content will be generated during gameplay if the player travels here.
    override init() {
        super.init()
    }
    
    /// Initialises with content (content won't be generated and injected during gameplay).
    /// - Parameters:
    ///   - restorer: This location's restorer
    init(restorer: Restorer) {
        self.generatedRestorer = restorer
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case restorer
    }

    required init(dataObject: DataObject) {
        self.generatedRestorer = dataObject.getObjectOptional(Field.restorer.rawValue, type: Restorer.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.restorer.rawValue, value: self.generatedRestorer)
    }
    
    // MARK: - Functions
    
    /// Initialises any required content for the player to interact with. Only called if the player is travelling here.
    /// - Parameters:
    ///   - contentManager: The content manager to generate any required content for this location
    func initContent(using contentManager: ContentManager) {
        guard self.generatedRestorer == nil else {
            if self.restorer.contentID == nil {
                contentManager.assignRestorerProfile(to: self.restorer, using: self.context)
            }
            return
        }
        self.generatedRestorer = contentManager.generateRestorer(using: self.context)
    }
    
    func getInteractor() -> InteractorAbstract? {
        return self.generatedRestorer
    }
    
}
