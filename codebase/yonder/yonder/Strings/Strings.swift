//
//  Strings.swift
//  yonder
//
//  Created by Andre Pham on 16/6/2022.
//

import Foundation

enum Strings: String, Localizable {
    static let parent: LocalizeParent = nil
    
    case GameName
    
    enum MainMenu: String, Localizable {
        static let parent: LocalizeParent = Strings.self
        
        case NewGame
        case ResumeGame
    }
}
