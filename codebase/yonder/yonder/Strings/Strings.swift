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
    
    enum TabBar: Localizable {
        static let parent: LocalizeParent = Strings.self
        
        case Game
        case Inventory
        case Map
        case Settings
    }
    
    enum OptionsMenu: Localizable {
        static let parent: LocalizeParent = Strings.self
        
        enum Header: Localizable {
            static let parent: LocalizeParent = OptionsMenu.self
            
            case Default
            case Weapon
            case Potion
            case Offer
            case Restoration
            case Shop
            case Enhance
        }
    }
    
    enum Inventory: Localizable {
        static let parent: LocalizeParent = Strings.self
        
        enum Title: Localizable {
            static let parent: LocalizeParent = Inventory.self
            
            case Armor
            case Accessories
            case Items
        }
        
        enum Weapons: Localizable {
            static let parent: LocalizeParent = Inventory.self
            
            case Header
            case HeaderZeroWeapons
            case Option
        }
        
        enum Potions: Localizable {
            static let parent: LocalizeParent = Inventory.self
            
            case Header
            case HeaderZeroPotions
            case Option
        }
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
    
    enum Weapon: Localizable {
        static let parent: LocalizeParent = Strings.self
        
        case RemainingUses
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
        
        case RemainingUses
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
    
    enum Map: Localizable {
        static let parent: LocalizeParent = Strings.self
        
        enum Header: Localizable {
            static let parent: LocalizeParent = Map.self
            
            case Done
            case Travel
            case InformationShorthand
        }
        
        enum LocationType: Localizable {
            static let parent: LocalizeParent = Map.self
            
            enum None: Localizable {
                static let parent: LocalizeParent = LocationType.self
                
                case Name
                case Description
            }
            
            enum Hostile: Localizable {
                static let parent: LocalizeParent = LocationType.self
                
                case Name
                case Description
            }
            
            enum ChallengeHostile: Localizable {
                static let parent: LocalizeParent = LocationType.self
                
                case Name
                case Description
            }
            
            enum Shop: Localizable {
                static let parent: LocalizeParent = LocationType.self
                
                case Name
                case Description
            }
            
            enum Enhancer: Localizable {
                static let parent: LocalizeParent = LocationType.self
                
                case Name
                case Description
            }
            
            enum Restorer: Localizable {
                static let parent: LocalizeParent = LocationType.self
                
                case Name
                case Description
            }
            
            enum Quest: Localizable {
                static let parent: LocalizeParent = LocationType.self
                
                case Name
                case Description
            }
            
            enum Friendly: Localizable {
                static let parent: LocalizeParent = LocationType.self
                
                case Name
                case Description
            }
            
            enum Boss: Localizable {
                static let parent: LocalizeParent = LocationType.self
                
                case Name
                case Description
            }
            
            enum Bridge: Localizable {
                static let parent: LocalizeParent = LocationType.self
                
                case Name
                case Description
            }
        }
    }
    
    enum Armor: Localizable {
        static let parent: LocalizeParent = Strings.self
        
        case ArmorSlot
        
        enum ArmorType: Localizable {
            static let parent: LocalizeParent = Armor.self
            
            enum Head: Localizable {
                static let parent: LocalizeParent = ArmorType.self
                
                case Name
            }
            
            enum Legs: Localizable {
                static let parent: LocalizeParent = ArmorType.self
                
                case Name
            }
            
            enum Body: Localizable {
                static let parent: LocalizeParent = ArmorType.self
                
                case Name
            }
        }
        
        enum NoArmor: Localizable {
            static let parent: LocalizeParent = Armor.self
            
            case Name
            case HeadDescription
            case BodyDescription
            case LegsDescription
        }
    }
}
