//
//  AnimationSequenceBuilder.swift
//  yonder
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation
import UIKit
import SwiftyJSON

class AnimationSequenceBuilder {
    
    /// The file name (and content ID) to be reading from - here purely for debugging purposes
    private let fileID: String
    /// The image that contains every frame of every animation
    private let spriteSheet: UIImage
    /// The JSON data that has the frame durations, positions and sizes of every frame of every animation
    private let framesDataJSON: JSON
    
    init(fileID: String, spriteSheet: UIImage, framesDataJSON: JSON) {
        self.fileID = fileID
        self.spriteSheet = spriteSheet
        self.framesDataJSON = framesDataJSON
    }
    
    func build(prefix: String) -> AnimationSequence? {
        guard let frameDuration = self.framesDataJSON["\(prefix)_frame_duration"].double else {
            assertionFailure("Frame duration could not be read from JSON")
            return nil
        }
        guard let frameOriginsJSON = self.framesDataJSON["\(prefix)_coords"].array else {
            assertionFailure("Frame origins could not be read from JSON")
            return nil
        }
        var frameOrigins = [SpriteSheetCoord]()
        for originJSON in frameOriginsJSON {
            guard let x = originJSON["x"].int, let y = originJSON["y"].int else {
                assertionFailure("Origin coordinate could not be read from JSON")
                return nil
            }
            frameOrigins.append(SpriteSheetCoord(x: x, y: y))
        }
        guard let frameWidth = self.framesDataJSON["frame_width"].int,
              let frameHeight = self.framesDataJSON["frame_height"].int else {
            assertionFailure("Frame width/height could not be read from JSON")
            return nil
        }
        return AnimationSequence(
            spriteSheet: self.spriteSheet,
            frameDuration: frameDuration,
            frameOrigins: frameOrigins,
            frameSize: (width: frameWidth, height: frameHeight)
        )
    }
    
}
