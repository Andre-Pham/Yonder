//
//  AnimationSequence.swift
//  Animation
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation
import SwiftUI

protocol ManagesSequences {
    
    func onNewFrame(_ frame: Image)
    
}

class AnimationSequence {
    
    private let spriteSheet: UIImage
    private let frameDuration: Double
    private let frameOrigins: [ImageCoords]
    private let frameSize: (width: Int, height: Int)
    private var frameIndex = 0 {
        didSet {
            self.frameDelegate?.onNewFrame(self.frame)
        }
    }
    private var frameCount: Int {
        return self.frameOrigins.count
    }
    private var frameRect: CGRect {
        let origin = self.frameOrigins[self.frameIndex]
        return CGRect(x: origin.x, y: origin.y, width: self.frameSize.width, height: self.frameSize.height)
    }
    public var frame: Image {
        let cropped = self.cropImage(self.spriteSheet, toRect: self.frameRect)
        return Image(uiImage: cropped!)
    }
    private var frameDelegate: ManagesSequences? = nil
    
    private var timer = CustomTimer()
    
    init(
        spriteSheet: UIImage,
        frameDuration: Double,
        frameOrigins: [ImageCoords],
        frameSize: (width: Int, height: Int)
    ) {
        self.spriteSheet = spriteSheet
        self.frameDuration = frameDuration
        self.frameOrigins = frameOrigins
        self.frameSize = frameSize
    }
    
    func setDelegate(to frameDelegate: ManagesSequences) {
        self.frameDelegate = frameDelegate
    }
    
    func start() {
        self.timer.start(withTimeInterval: self.frameDuration) {
            self.incrementFrame()
        }
    }
    
    func pause() {
        self.timer.stop()
    }
    
    func stop() {
        self.timer.stop()
        self.frameIndex = 0
    }
    
    func restart() {
        self.stop()
        self.start()
    }
    
    private func incrementFrame() {
        self.frameIndex = (self.frameIndex + 1)%self.frameCount
    }
    
    private func cropImage(_ sourceImage: UIImage, toRect cropRect: CGRect) -> UIImage? {
        // MARK: Note: This is much MUCH faster compared to UIGraphicsBeginImageContextWithOptions
        let sourceCGImage = sourceImage.cgImage!
        let croppedCGImage = sourceCGImage.cropping(
            to: cropRect
        )!

        // Use the cropped cgImage to initialize a cropped
        // UIImage with the same image scale and orientation
        let croppedImage = UIImage(
            cgImage: croppedCGImage,
            scale: sourceImage.imageRendererFormat.scale,
            orientation: sourceImage.imageOrientation
        )
        return croppedImage
    }
    
}
