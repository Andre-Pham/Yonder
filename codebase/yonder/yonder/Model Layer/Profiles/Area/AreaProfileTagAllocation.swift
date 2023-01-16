//
//  AreaProfileTagAllocation.swift
//  yonder
//
//  Created by Andre Pham on 8/11/2022.
//

import Foundation

class AreaProfileTagAllocation: Storable {
    
    private let tags: [AreaProfileTag]
    private let weights: [Int]
    private var count: Int {
        return self.tags.count
    }
    
    init(tags: (AreaProfileTag, Int)...) {
        self.tags = tags.map { $0.0 }
        self.weights = tags.map { $0.1 }
        assert(self.weights.allSatisfy({ $0 > 0 }), "negative weight provided")
    }
    
    func getTag() -> AreaProfileTag {
        let index = FactoryUtil.randomWeightedIndex(self.weights)
        return self.tags[index]
    }
    
    // MARK: - Serialisation
    
    private enum Field: String {
        case tags
        case weights
    }
    
    required init(dataObject: DataObject) {
        // If a tag isn't restored, its corresponding weights must also not be restored
        let readTags: [AreaProfileTag?] = dataObject.get(Field.tags.rawValue).map({ AreaProfileTag(rawValue: $0) })
        let readWeights: [Int] = dataObject.get(Field.weights.rawValue)
        var restorableTags = [AreaProfileTag]()
        var restorableWeights = [Int]()
        for tagIndex in 0..<readTags.count {
            if let tag = readTags[tagIndex] {
                restorableTags.append(tag)
                restorableWeights.append(readWeights[tagIndex])
            }
        }
        self.tags = restorableTags
        self.weights = restorableWeights
    }
    
    func toDataObject() -> DataObject {
        return DataObject(self)
            .add(key: Field.tags.rawValue, value: self.tags.map({ $0.rawValue }))
            .add(key: Field.weights.rawValue, value: self.weights)
    }
    
}
