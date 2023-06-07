//
//  ImageManager.swift
//  Animation
//
//  Created by Andre Pham on 8/6/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON

struct ImageCoords {
    public let x: Int
    public let y: Int
}

class ImageManager {
    
    private let fullImage: UIImage
    private let json: JSON
    private var breathingCoords = [ImageCoords]()
    private let imageSize: ImageCoords
    public var image: Image {
        return Image(uiImage: self.fullImage)
    }
    public var croppedImage: Image {
        let origin = self.breathingCoords[0]
        let image = self.cropImage(self.fullImage, toRect: CGRect(x: origin.x, y: origin.y, width: self.imageSize.x, height: self.imageSize.y))
        return Image(uiImage: image!)
    }
    public var croppedImage2: Image {
        let origin = self.breathingCoords[0]
        let image = self.cropImage2(self.fullImage, toRect: CGRect(x: origin.x, y: origin.y, width: self.imageSize.x, height: self.imageSize.y))
        return Image(uiImage: image!)
    }
    
    init(imageName: String) {
        self.fullImage = UIImage(named: imageName)!
        let fileURL = Bundle.main.url(forResource: "FRAMES-E0001", withExtension: "json")!
        let data = (try? Data(contentsOf: fileURL))!
        self.json = (try? JSON(data: data))!
        for coord in self.json["breathing_coords"].arrayValue {
            self.breathingCoords.append(ImageCoords(x: coord["x"].intValue, y: coord["y"].intValue))
        }
        self.imageSize = ImageCoords(x: self.json["frame_width"].intValue, y: self.json["frame_height"].intValue)
        
        print("Hello?")
        
        TestPerformance.executionDuration(printedTaskName: "cropImage") {
            for _ in 0..<100000 {
                let origin = self.breathingCoords[0]
                let image = self.cropImage(self.fullImage, toRect: CGRect(x: origin.x, y: origin.y, width: self.imageSize.x, height: self.imageSize.y))
            }
        }
        
        TestPerformance.executionDuration(printedTaskName: "cropImage2") {
            for _ in 0..<100000 {
                let origin = self.breathingCoords[0]
                let image = self.cropImage2(self.fullImage, toRect: CGRect(x: origin.x, y: origin.y, width: self.imageSize.x, height: self.imageSize.y))
            }
        }
    }
    
    func cropImage2(_ sourceImage: UIImage, toRect cropRect: CGRect) -> UIImage? {
        // MARK: Note: This is much MUCH faster compared to UIGraphicsBeginImageContextWithOptions
        // The shortest side
        let sideLength = min(
            sourceImage.size.width,
            sourceImage.size.height
        )

        // Determines the x,y coordinate of a centered
        // sideLength by sideLength square
        let sourceSize = sourceImage.size
        let xOffset = (sourceSize.width - sideLength) / 2.0
        let yOffset = (sourceSize.height - sideLength) / 2.0

        // Center crop the image
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
    
    func cropImage(_ originalImage: UIImage, toRect cropRect: CGRect) -> UIImage? {
        // Calculate the scale factor based on the image's orientation
        let scale = originalImage.scale
        
        // Calculate the crop rectangle in image coordinates
        let cropRectInImage = CGRect(x: cropRect.origin.x * scale,
                                     y: cropRect.origin.y * scale,
                                     width: cropRect.size.width * scale,
                                     height: cropRect.size.height * scale)
        
        // Create a graphics context using the cropped size
        UIGraphicsBeginImageContextWithOptions(cropRectInImage.size, false, scale)
        
        // Draw the cropped portion of the image in the graphics context
        originalImage.draw(at: CGPoint(x: -cropRectInImage.origin.x, y: -cropRectInImage.origin.y))
        
        // Get the cropped image from the graphics context
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the graphics context
        UIGraphicsEndImageContext()
        
        return croppedImage
    }
    
}
