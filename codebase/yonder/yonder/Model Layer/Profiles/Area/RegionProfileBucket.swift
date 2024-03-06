//
//  RegionProfileBucket.swift
//  yonder
//
//  Created by Andre Pham on 6/11/2022.
//

import Foundation

class RegionProfileBucket {
    
    private var profiles: [[RegionProfile]] = [
        // Stage 0
        [
            RegionProfile(
                regionName: Strings("map.region.forest.name").local,
                regionDescription: Strings("map.region.forest.description").local,
                regionBackground: YonderImages.forestBackgroundImage,
                regionForeground: YonderImages.forestForegroundImage,
                tags: RegionTagAllocation(tags: (.forest, 1)),
                assignment: .area
            ),
            RegionProfile(
                regionName: Strings("map.region.faction5.name").local,
                regionDescription: Strings("map.region.faction5.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.faction5, 1)),
                assignment: .area
            ),
            RegionProfile(
                regionName: Strings("map.region.tavern0.name").local,
                regionDescription: Strings("map.region.tavern0.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.forest, 1), (.faction5, 1)),
                assignment: .tavernArea
            ),
        ],
        // Stage 1
        [
            RegionProfile(
                regionName: Strings("map.region.cavern.name").local,
                regionDescription: Strings("map.region.cavern.description").local,
                regionBackground: YonderImages.cavernBackgroundImage,
                regionForeground: YonderImages.cavernForegroundImage,
                tags: RegionTagAllocation(tags: (.cavern, 1)),
                assignment: .area
            ),
            RegionProfile(
                regionName: Strings("map.region.desert.name").local,
                regionDescription: Strings("map.region.desert.description").local,
                regionBackground: YonderImages.desertBackgroundImage,
                regionForeground: YonderImages.desertForegroundImage,
                tags: RegionTagAllocation(tags: (.desert, 1)),
                assignment: .area
            ),
            RegionProfile(
                regionName: Strings("map.region.tavern1.name").local,
                regionDescription: Strings("map.region.tavern1.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.cavern, 1), (.desert, 1)),
                assignment: .tavernArea
            ),
        ],
        // Stage 2
        [
            RegionProfile(
                regionName: Strings("map.region.shadow.name").local,
                regionDescription: Strings("map.region.shadow.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.shadow, 1)),
                assignment: .area
            ),
            RegionProfile(
                regionName: Strings("map.region.faction4.name").local,
                regionDescription: Strings("map.region.faction4.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.faction4, 1)),
                assignment: .area
            ),
            RegionProfile(
                regionName: Strings("map.region.tavern2.name").local,
                regionDescription: Strings("map.region.tavern2.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.shadow, 1), (.faction4, 1)),
                assignment: .tavernArea
            ),
        ],
        // Stage 3
        [
            RegionProfile(
                regionName: Strings("map.region.frost.name").local,
                regionDescription: Strings("map.region.frost.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.frost, 1)),
                assignment: .area
            ),
            RegionProfile(
                regionName: Strings("map.region.faction6.name").local,
                regionDescription: Strings("map.region.faction6.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.faction6, 1)),
                assignment: .area
            ),
            RegionProfile(
                regionName: Strings("map.region.tavern3.name").local,
                regionDescription: Strings("map.region.tavern3.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.frost, 1), (.faction6, 1)),
                assignment: .tavernArea
            ),
        ],
        // Stage 4
        [
            RegionProfile(
                regionName: Strings("map.region.dungeon.name").local,
                regionDescription: Strings("map.region.dungeon.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.dungeon, 1)),
                assignment: .area
            ),
            RegionProfile(
                regionName: Strings("map.region.mech.name").local,
                regionDescription: Strings("map.region.mech.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.mech, 1)),
                assignment: .area
            ),
            RegionProfile(
                regionName: Strings("map.region.tavern4.name").local,
                regionDescription: Strings("map.region.tavern4.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.dungeon, 1), (.mech, 1)),
                assignment: .tavernArea
            ),
        ],
        // Stage 5
        [
            RegionProfile(
                regionName: Strings("map.region.nether.name").local,
                regionDescription: Strings("map.region.nether.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.nether, 1)),
                assignment: .area
            ),
            RegionProfile(
                regionName: Strings("map.region.faction2.name").local,
                regionDescription: Strings("map.region.faction2.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.faction2, 1)),
                assignment: .area
            ),
            RegionProfile(
                regionName: Strings("map.region.tavern5.name").local,
                regionDescription: Strings("map.region.tavern5.description").local,
                regionBackground: YonderImages.missingBackgroundImage,
                regionForeground: YonderImages.missingForegroundImage,
                tags: RegionTagAllocation(tags: (.nether, 1), (.faction2, 1)),
                assignment: .tavernArea
            ),
        ],
    ]
    
    func grabProfile(stage: Int, regionAssignment: RegionProfileAssignment) -> RegionProfile {
        assert(self.profiles.count > stage, "Requesting profile from non-existent stage")
        let stageProfiles = self.profiles[stage]
        assert(!stageProfiles.isEmpty, "Attempted to grab a profile when there are none left for the provided stage")
        var validIndices = [Int]()
        for (index, stageProfile) in stageProfiles.enumerated() {
            if regionAssignment == .any || stageProfile.assignment == .any || regionAssignment == stageProfile.assignment {
                validIndices.append(index)
            }
        }
        assert(!validIndices.isEmpty, "Attempted to grab a profile when there are none left with the requested region assignment")
        let index = validIndices.randomElement()!
        // Arrays are value types, not reference types, so the nested array must be accessed again (not referenced by variable)
        return self.profiles[stage].remove(at: index)
    }
    
    func grabProfiles(count: Int, stage: Int, regionAssignment: RegionProfileAssignment) -> [RegionProfile] {
        var profiles = [RegionProfile]()
        for _ in 0..<count {
            profiles.append(self.grabProfile(stage: stage, regionAssignment: regionAssignment))
        }
        return profiles
    }
    
}
