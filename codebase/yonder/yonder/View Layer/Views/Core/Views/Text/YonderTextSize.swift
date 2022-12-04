//
//  YonderTextSize.swift
//  yonder
//
//  Created by Andre Pham on 16/4/2022.
//

import Foundation
import SwiftUI

enum YonderTextSize {
    
    case title1
    case title2
    case title3
    case title4
    case title5
    
    case buttonBody
    case buttonBodySubscript
    case tabBar
    case tabBarIconCapsule
    
    case cardTitle
    case cardBody
    case cardSubscript
    
    case inspectSheetTitle
    case inspectSheetBody
    
    case optionBody
    
    var value: CGFloat {
        switch self {
        case .title1: return 70
        case .title2: return 50
        case .title3: return 35
        case .title4: return 25 // TEMP choice
        case .title5: return 20
            
        case .buttonBody: return 24
        case .buttonBodySubscript: return 18
        case .tabBar: return 14
        case .tabBarIconCapsule: return 28
            
        case .cardTitle: return 18
        case .cardBody: return 26
        case .cardSubscript: return 18
        
        case .inspectSheetTitle: return 28
        case .inspectSheetBody: return 20
            
        case .optionBody: return 16
        }
    }
    
    func height(of string: String) -> CGFloat {
        let size: CGSize = string.size(withAttributes: [.font: UIFont(name: "Mx437_DOS-V_TWN16", size: self.value)!])
        return size.height/2 // This font requires /2 for some reason
    }
    
    func width(of string: String) -> CGFloat {
        let size: CGSize = string.size(withAttributes: [.font: UIFont(name: "Mx437_DOS-V_TWN16", size: self.value)!])
        return size.width/2 // This font requires /2 for some reason
    }
    
}
