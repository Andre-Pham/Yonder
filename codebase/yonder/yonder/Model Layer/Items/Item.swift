//
//  Item.swift
//  yonder
//
//  Created by Andre Pham on 20/11/21.
//

import Foundation

typealias ItemAbstract = ItemAbstractPart & EffectsDescribed

class ItemAbstractPart: Named, Described {
    
    @DidSetPublished private(set) var name: String
    @DidSetPublished private(set) var description: String
    @DidSetPublished private(set) var damage: Int {
        didSet {
            self.damageDidSet()
            self.damageSubscribers.forEach({ $0.onDamageChange(self as! ItemAbstract, old: oldValue) })
        }
    }
    @DidSetPublished private(set) var restoration: Int {
        didSet {
            self.restorationDidSet()
            self.restorationSubscribers.forEach({ $0.onRestorationChange(self as! ItemAbstract, old: oldValue) })
        }
    }
    @DidSetPublished private(set) var healthRestoration: Int {
        didSet {
            self.healthRestorationDidSet()
            self.healthRestorationSubscribers.forEach({ $0.onHealthRestorationChange(self as! ItemAbstract, old: oldValue) })
        }
    }
    @DidSetPublished private(set) var armorPointsRestoration: Int {
        didSet {
            self.armorPointsRestorationDidSet()
            self.armorPointsRestorationSubscribers.forEach({ $0.onArmorPointsRestorationChange(self as! ItemAbstract, old: oldValue) })
        }
    }
    @DidSetPublished private(set) var remainingUses: Int {
        didSet {
            self.remainingUsesDidSet()
            self.remainingUsesSubscribers.forEach({ $0.onRemainingUsesChange(self as! ItemAbstract, old: oldValue) })
        }
    }
    private(set) var damageSubscribers = [DamageSubscriber]()
    private(set) var restorationSubscribers = [RestorationSubscriber]()
    private(set) var healthRestorationSubscribers = [HealthRestorationSubscriber]()
    private(set) var armorPointsRestorationSubscribers = [ArmorPointsRestorationSubscriber]()
    private(set) var remainingUsesSubscribers = [RemainingUsesSubscriber]()
    /// Indicates if the item has infinite uses or not - not actually used in logic, but as an indicator for rendering the UI
    private(set) var infiniteRemainingUses: Bool
    public let id = UUID()
    public let requiresFoeForUsage: Bool
    
    init(name: String, description: String, remainingUses: Int = 0, damage: Int = 0, restoration: Int = 0, healthRestoration: Int = 0, armorPointsRestoration: Int = 0, infiniteRemainingUses: Bool = false, requiresFoeForUsage: Bool = true) {
        self.name = name
        self.description = description
        self.remainingUses = remainingUses
        self.damage = damage
        self.restoration = restoration
        self.healthRestoration = healthRestoration
        self.armorPointsRestoration = armorPointsRestoration
        self.infiniteRemainingUses = infiniteRemainingUses
        self.requiresFoeForUsage = requiresFoeForUsage
    }
    
    // MARK: - Setters
    
    func setRemainingUses(to uses: Int) {
        self.remainingUses = uses
    }
    
    func setDamage(to damage: Int) {
        self.damage = damage
    }
    
    func setRestoration(to restoration: Int) {
        self.restoration = restoration
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
    
    func setName(to name: String) {
        self.name = name
    }
    
    func setDescription(to description: String) {
        self.description = description
    }
    
    // MARK: - Adjusters
    
    func adjustRemainingUses(by uses: Int) {
        self.remainingUses += uses
    }
    
    func adjustDamage(by damage: Int) {
        self.damage += damage
    }
    
    func adjustRestoration(by restoration: Int) {
        self.restoration += restoration
    }
    
    func adjustHealthRestoration(by healthRestoration: Int) {
        self.healthRestoration += healthRestoration
    }
    
    func adjustArmorPointsRestoration(by armorPointsRestoration: Int) {
        self.armorPointsRestoration += armorPointsRestoration
    }
    
    // MARK: - Subclasses
    
    /// Override these in subclasses if you wish to observe these properties.
    func damageDidSet() { }
    func restorationDidSet() { }
    func healthRestorationDidSet() { }
    func armorPointsRestorationDidSet() { }
    func remainingUsesDidSet() { }
    
    // MARK: - Subscribers
    
    func addDamageSubscriber(_ subscriber: DamageSubscriber) {
        self.damageSubscribers.append(subscriber)
    }
    
    func addRestorationSubscriber(_ subscriber: RestorationSubscriber) {
        self.restorationSubscribers.append(subscriber)
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
