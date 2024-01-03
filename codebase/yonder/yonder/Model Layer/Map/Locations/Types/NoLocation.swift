//
//  NoLocation.swift
//  yonder
//
//  Created by Andre Pham on 30/11/21.
//

import Foundation

class NoLocation: Location {
    
    public let type: LocationType = .none
    
    override init() {
        super.init()
        self.setContext(key: "", name: "placeholderName", description: "placeholderDescription", imageResource: YonderImages.missingBackgroundImage)
    }
    
    // MARK: - Serialisation
    
    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }
    
    override func toDataObject() -> DataObject {
        return super.toDataObject()
    }
    
    // MARK: - Functions
    
    /// Initialises any required content for the player to interact with. Only called if the player is travelling here.
    /// - Parameters:
    ///   - contentManager: The content manager to generate any required content for this location
    func initContent(using contentManager: ContentManager) {
        // No content to initialise
    }
    
}
