//
//  UIProtocols.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation
import SwiftUI

typealias NamedDescribedVisualised = Named & Described & Visualised
typealias NamedDescribed = Named & Described
typealias NamedVisualised = Named & Visualised

protocol Named {
    
    var name: String { get }
    
}

protocol Described {
    
    var description: String { get }
    
}

protocol Visualised {
    
    var image: Image { get }
    
}
