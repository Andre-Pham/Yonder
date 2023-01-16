//
//  AreaThemed.swift
//  yonder
//
//  Created by Andre Pham on 14/1/2023.
//

import Foundation

protocol AreaThemed: Named, Described {
    
    var imageResource: ImageResource { get }
    var tags: AreaProfileTagAllocation { get }
    
    func getAreaKey() -> String
    
}
