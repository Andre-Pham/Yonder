//
//  NoAnimationSequence.swift
//  yonder
//
//  Created by Andre Pham on 10/6/2023.
//

import Foundation
import SwiftUI

class NoAnimationSequence: AnimationSequence {
    
    override var frame: Image {
        // Blank image
        return Image(uiImage: UIImage())
    }
    
    init() {
        super.init(spriteSheet: UIImage(), frameDuration: 0.0, frameOrigins: [], frameSize: (0, 0))
    }
    
    override func play() {
        // Do nothing
    }
    
}
