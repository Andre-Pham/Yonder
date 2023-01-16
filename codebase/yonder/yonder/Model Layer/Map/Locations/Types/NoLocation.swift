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
        self.setContext(key: "", name: "placeholderName", description: "placeholderDescription", imageResource: YonderImages.placeholderImage)
    }
    
    required init(dataObject: DataObject) {
        super.init(dataObject: dataObject)
    }
    
    func initContent(using contentManager: ContentManager) { }
    
}
