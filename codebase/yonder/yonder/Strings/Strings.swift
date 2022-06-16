//
//  Strings.swift
//  yonder
//
//  Created by Andre Pham on 16/6/2022.
//

import Foundation

enum Strings: Localizable {
    static let parent: LocalizeParent = nil
    
    case GameName
    
    enum MainMenu: Localizable {
        static let parent: LocalizeParent = Strings.self
        
        case NewGame
        case ResumeGame
    }
    
    enum EnhanceOffer: Localizable {
        static let parent: LocalizeParent = Strings.self
        
        enum WeaponDamage: Localizable {
            static let parent: LocalizeParent = EnhanceOffer.self
            
            case Name
            case Description1Param
        }
        
        enum ArmorPoints: Localizable {
            static let parent: LocalizeParent = EnhanceOffer.self
            
            case Name
            case Description1Param
        }
        
        enum ArmorBuff: Localizable {
            static let parent: LocalizeParent = EnhanceOffer.self
            
            case Name
            case Description1Param
            case MissingDescription
        }
        
        enum WeaponEffect: Localizable {
            static let parent: LocalizeParent = EnhanceOffer.self
            
            case Name
            case Description1Param
        }
        
        enum WeaponDurability: Localizable {
            static let parent: LocalizeParent = EnhanceOffer.self
            
            case Name
            case Description1Param
        }
    }
}
