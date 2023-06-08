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
    
    init(imageName: String) {
        self.fullImage = UIImage(named: imageName)!
        let fileURL = Bundle.main.url(forResource: "FRAMES-E0001", withExtension: "json")!
        let data = (try? Data(contentsOf: fileURL))!
        self.json = (try? JSON(data: data))!
        for coord in self.json["breathing_coords"].arrayValue {
            self.breathingCoords.append(ImageCoords(x: coord["x"].intValue, y: coord["y"].intValue))
        }
        self.imageSize = ImageCoords(x: self.json["frame_width"].intValue, y: self.json["frame_height"].intValue)
    }
    
    func cropImage(_ sourceImage: UIImage, toRect cropRect: CGRect) -> UIImage? {
        // MARK: Note: This is much MUCH faster compared to UIGraphicsBeginImageContextWithOptions
        // The shortest side
        let sideLength = min(
            sourceImage.size.width,
            sourceImage.size.height
        )

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
