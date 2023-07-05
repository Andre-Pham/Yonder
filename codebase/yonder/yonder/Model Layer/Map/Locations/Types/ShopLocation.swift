//
//  ShopLocation.swift
//  yonder
//
//  Created by Andre Pham on 3/12/21.
//

import Foundation

class ShopLocation: Location, InteractorLocation {
    
    /// The shop keeper of the location - only generated when the player visits this location
    private var generatedShopKeeper: ShopKeeper? = nil
    /// An accessor for the generated shop keeper - external classes should always assume any content it requires is already generated otherwise something has gone seriously wrong
    public var shopKeeper: ShopKeeper {
        assert(self.generatedShopKeeper != nil, "Content is being retrieved from a location before initContent method called")
        return self.generatedShopKeeper!
    }
    /// The location type - corresponds to class type but allows exhaustive switch cases and associated data
    public let type: LocationType = .shop
    
    /// Initialises without any content - content will be generated during gameplay if the player travels here.
    override init() {
        super.init()
    }
    
    /// Initialises with content (content won't be generated and injected during gameplay).
    /// - Parameters:
    ///   - shopKeeper: This location's shop keeper
    init(shopKeeper: ShopKeeper) {
        self.generatedShopKeeper = shopKeeper
        super.init()
    }
    
    // MARK: - Serialisation

    private enum Field: String {
        case shopKeeper
    }

    required init(dataObject: DataObject) {
        self.generatedShopKeeper = dataObject.getObjectOptional(Field.shopKeeper.rawValue, type: ShopKeeper.self)
        super.init(dataObject: dataObject)
    }

    override func toDataObject() -> DataObject {
        return super.toDataObject()
            .add(key: Field.shopKeeper.rawValue, value: self.generatedShopKeeper)
    }
    
    // MARK: - Functions
    
    /// Initialises any required content for the player to interact with. Only called if the player is travelling here.
    /// - Parameters:
    ///   - contentManager: The content manager to generate any required content for this location
    func initContent(using contentManager: ContentManager) {
        guard self.generatedShopKeeper == nil else {
            return
        }
        self.generatedShopKeeper = contentManager.generateShopKeeper(using: self.context)
    }
    
    func getInteractor() -> InteractorAbstract? {
        return self.generatedShopKeeper
    }
    
}
