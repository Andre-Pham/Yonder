//
//  BuildTokenFactory.swift
//  yonder
//
//  Created by Andre Pham on 8/7/2023.
//

import Foundation

protocol BuildTokenFactory: AnyObject {
    
    associatedtype BuildToken: RawRepresentable where BuildToken.RawValue == String
    
    /// WARNING: This is only publicly mutable as a protocol requirement, don't actually mutate this from outside the class
    /// The queue of build tokens to serve in order to determine the type of whatever the factory is producing
    var buildTokenQueue: [BuildToken] { get set }
    
}
extension BuildTokenFactory {
    
    func exportBuildTokenCache(regionKey: String) -> BuildTokenCache {
        return BuildTokenCache(regionKey: regionKey, serialisedTokens: self.buildTokenQueue.map({ $0.rawValue }))
    }
    
    func importSerialisedTokens(_ buildTokenCache: BuildTokenCache) {
        let tokenStrings = buildTokenCache.serialisedTokens
        for tokenString in tokenStrings {
            if let restoredToken = BuildToken(rawValue: tokenString) {
                self.buildTokenQueue.append(restoredToken)
            }
        }
    }
    
}
