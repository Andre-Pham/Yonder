//
//  SequenceDelegate.swift
//  yonder
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation
import SwiftUI

protocol SequenceDelegate {
    
    func onNewFrame(_ frame: Image)
    func onSequenceEnd()
    
}
