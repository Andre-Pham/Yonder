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
    
    enum WeaponDurabilityPill: Localizable {
        static let parent: LocalizeParent = Strings.self
        
        enum Decrement: Localizable {
            static let parent: LocalizeParent = WeaponDurabilityPill.self
            
            case Description1Param
        }
        
        enum Dulling: Localizable {
            static let parent: LocalizeParent = WeaponDurabilityPill.self
            
            case Description1Param
        }
        
        enum Infinite: Localizable {
            static let parent: LocalizeParent = WeaponDurabilityPill.self
            
            case Description
        }
    }
    
    enum WeaponEffectPill: Localizable {
        static let parent: LocalizeParent = Strings.self
        
        enum BurnStatusEffect: Localizable {
            static let parent: LocalizeParent = WeaponEffectPill.self
            
            case Description1Param
        }
    }
    
    enum Potion: Localizable {
        static let parent: LocalizeParent = Strings.self
        
        case Tier1
        case Tier2
        case Tier3
        case Tier4
        case Tier5
        
        enum HealthRestoration: Localizable {
            static let parent: LocalizeParent = Potion.self
            
            case Name
            case Description
            case EffectsDescription1Param
        }
        
        enum Damage: Localizable {
            static let parent: LocalizeParent = Potion.self
            
            case Name
            case Description
            case EffectsDescription1Param
        }
        
        enum MaxHealthRestoration: Localizable {
            static let parent: LocalizeParent = Potion.self
            
            case Name
            case Description
            case EffectsDescription
        }
        
        enum MaxRestoration: Localizable {
            static let parent: LocalizeParent = Potion.self
            
            case Name
            case Description
            case EffectsDescription
        }
    }
    
    enum Buff: Localizable {
        static let parent: LocalizeParent = Strings.self
        
        enum DamagePercent: Localizable {
            static let parent: LocalizeParent = Buff.self
            
            enum EffectsDescription: Localizable {
                static let parent: LocalizeParent = DamagePercent.self
                
                case BidirectionalIncrease1Param
                case BidirectionalDecrease1Param
                case IncomingIncrease1Param
                case IncomingDecrease1Param
                case OutgoingIncrease1Param
                case OutgoingDecrease1Param
            }
        }
        
        enum Damage: Localizable {
            static let parent: LocalizeParent = Buff.self
            
            enum EffectsDescription: Localizable {
                static let parent: LocalizeParent = Damage.self
                
                case BidirectionalIncrease1Param
                case BidirectionalDecrease1Param
                case IncomingIncrease1Param
                case IncomingDecrease1Param
                case OutgoingIncrease1Param
                case OutgoingDecrease1Param
            }
        }
        
        enum HealthRestorationPercent: Localizable {
            static let parent: LocalizeParent = Buff.self
            
            enum EffectsDescription: Localizable {
                static let parent: LocalizeParent = HealthRestorationPercent.self
                
                case BidirectionalIncrease1Param
                case BidirectionalDecrease1Param
                case IncomingIncrease1Param
                case IncomingDecrease1Param
                case OutgoingIncrease1Param
                case OutgoingDecrease1Param
            }
        }
        
        enum ArmorRestorationPercent: Localizable {
            static let parent: LocalizeParent = Buff.self
            
            enum EffectsDescription: Localizable {
                static let parent: LocalizeParent = ArmorRestorationPercent.self
                
                case BidirectionalIncrease1Param
                case BidirectionalDecrease1Param
                case IncomingIncrease1Param
                case IncomingDecrease1Param
                case OutgoingIncrease1Param
                case OutgoingDecrease1Param
            }
        }
        
        enum PricePercent: Localizable {
            static let parent: LocalizeParent = Buff.self
            
            enum EffectsDescription: Localizable {
                static let parent: LocalizeParent = PricePercent.self
                
                case BidirectionalIncrease1Param
                case BidirectionalDecrease1Param
                case IncomingIncrease1Param
                case IncomingDecrease1Param
                case OutgoingIncrease1Param
                case OutgoingDecrease1Param
            }
        }
        
        enum PotionDamagePercent: Localizable {
            static let parent: LocalizeParent = Buff.self
            
            enum EffectsDescription: Localizable {
                static let parent: LocalizeParent = PotionDamagePercent.self
                
                case BidirectionalIncrease1Param
                case BidirectionalDecrease1Param
                case IncomingIncrease1Param
                case IncomingDecrease1Param
                case OutgoingIncrease1Param
                case OutgoingDecrease1Param
            }
        }
    }
}
