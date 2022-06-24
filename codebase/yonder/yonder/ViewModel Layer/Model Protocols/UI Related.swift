//
//  UIProtocols.swift
//  yonder
//
//  Created by Andre Pham on 27/12/21.
//

import Foundation
import SwiftUI

protocol Named {
    
    var name: String { get }
    
}

protocol EffectsDescribed {
    
    func getEffectsDescription() -> String?
    
}

protocol Described {
    
    var description: String { get }
    
}

protocol Visualised {
    
    var image: Image { get }
    
}
