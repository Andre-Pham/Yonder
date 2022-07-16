//
//  Item.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

typealias ItemAbstract = ItemAbstractPart & EffectsDescribed

class ItemAbstractPart: Named, Described {
    
    public let name: String
    public let description: String
    @DidSetPublished private(set) var damage: Int {
        didSet {
            self.damageSubscribers.forEach({ $0.onDamageChange(self as! ItemAbstract, old: oldValue) })
        }
    }
    @DidSetPublished private(set) var healthRestoration: Int {
        didSet {
            self.healthRestorationSubscribers.forEach({ $0.onHealthRestorationChange(self as! ItemAbstract, old: oldValue) })
        }
    }
    @DidSetPublished private(set) var armorPointsRestoration: Int {
        didSet {
            self.armorPointsRestorationSubscribers.forEach({ $0.onArmorPointsRestorationChange(self as! ItemAbstract, old: oldValue) })
        }
    }
    @DidSetPublished private(set) var remainingUses: Int {
        didSet {
            self.remainingUsesSubscribers.forEach({ $0.onRemainingUsesChange(self as! ItemAbstract, old: oldValue) })
        }
    }
    private(set) var damageSubscribers = [DamageSubscriber]()
    private(set) var healthRestorationSubscribers = [HealthRestorationSubscriber]()
    private(set) var armorPointsRestorationSubscribers = [ArmorPointsRestorationSubscriber]()
    private(set) var remainingUsesSubscribers = [RemainingUsesSubscriber]()
    /// Indicates if the item has infinite uses or not - not actually used in logic, but as an indicator for rendering the UI
    private(set) var infiniteRemainingUses: Bool
    public let id = UUID()
    
    init(name: String, description: String, remainingUses: Int = 0, damage: Int = 0, healthRestoration: Int = 0, armorPointsRestoration: Int = 0, infiniteRemainingUses: Bool = false) {
        self.name = name
        self.description = description
        self.remainingUses = remainingUses
        self.damage = damage
        self.healthRestoration = healthRestoration
        self.armorPointsRestoration = armorPointsRestoration
        self.infiniteRemainingUses = infiniteRemainingUses
    }
    
    // MARK: - Setters
    
    func setRemainingUses(to uses: Int) {
        self.remainingUses = uses
    }
    
    func setDamage(to damage: Int) {
        self.damage = damage
    }
    
    func setHealthRestoration(to healthRestoration: Int) {
        self.healthRestoration = healthRestoration
    }
    
    func setArmorPointsRestoration(to armorPointsRestoration: Int) {
        self.armorPointsRestoration = armorPointsRestoration
    }
    
    func setInfiniteRemainingUses(to status: Bool) {
        self.infiniteRemainingUses = status
    }
    
    // MARK: - Adjusters
    
    func adjustRemainingUses(by uses: Int) {
        self.remainingUses += uses
    }
    
    func adjustDamage(by damage: Int) {
        self.damage += damage
    }
    
    func adjustHealthRestoration(by healthRestoration: Int) {
        self.healthRestoration += healthRestoration
    }
    
    func adjustArmorPointsRestoration(by armorPointsRestoration: Int) {
        self.armorPointsRestoration += armorPointsRestoration
    }
    
    // MARK: - Subscribers
    
    func addDamageSubscriber(_ subscriber: DamageSubscriber) {
        self.damageSubscribers.append(subscriber)
    }
    
    func addHealthRestorationSubscriber(_ subscriber: HealthRestorationSubscriber) {
        self.healthRestorationSubscribers.append(subscriber)
    }
    
    func addArmorPointsRestorationSubscriber(_ subscriber: ArmorPointsRestorationSubscriber) {
        self.armorPointsRestorationSubscribers.append(subscriber)
    }
    
    func addRemainingUsesSubscriber(_ subscriber: RemainingUsesSubscriber) {
        self.remainingUsesSubscribers.append(subscriber)
    }
    
}
