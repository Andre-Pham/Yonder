//
//  YonderImage.swift
//  yonder
//
//  Created by Andre Pham on 3/12/2022.
//

import Foundation
import SwiftUI

class YonderImage {
    
    let name: String
    let width: CGFloat
    let height: CGFloat
    var image: Image {
        Image(self.name)
    }
    var uiImage: UIImage {
        UIImage(named: self.name)!
    }
    
    init(_ name: String) {
        let reference = UIImage(named: name)
        assert(reference != nil, "Resource name has no matching resource")
        self.name = name
        self.width = reference!.size.width
        self.height = reference!.size.height
    }
    
}