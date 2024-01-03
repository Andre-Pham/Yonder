//
//  Region.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2023.
//

import Foundation

/// A region is any grouping of locations that presents a particular setting. This includes a background image, related enemies, related bosses, and related interators.
protocol Region: Named, Described {
    
    var background: YonderImage { get }
    var foreground: YonderImage { get }
    var tags: RegionTagAllocation { get }
    
    func getRegionKey() -> String
    
}
