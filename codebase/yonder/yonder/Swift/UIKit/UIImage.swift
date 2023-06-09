//
//  UIImage.swift
//  yonder
//
//  Created by Andre Pham on 9/6/2023.
//

import Foundation
import UIKit

extension UIImage {
    
    /// Crops the image to the rectangle bounds.
    /// This algorithm has been tested and found to be MUCH faster in comparison to `UIGraphicsBeginImageContextWithOptions`.
    /// - Parameters:
    ///   - cropRect: The rectangle to crop the image to (must be bounded by the image)
    /// - Returns: A new cropped image
    func cropped(toRect cropRect: CGRect) -> UIImage? {
        assert(isGreaterZero(cropRect.width*cropRect.height), "Attempting to crop an image to 0x0")
        assert(isGreaterZero(cropRect.origin.x), "Attempting to crop out of bounds")
        assert(isGreaterZero(cropRect.origin.y), "Attempting to crop out of bounds")
        guard let croppedCGImage = self.cgImage?.cropping(to: cropRect) else {
            return nil
        }
        return UIImage(
            cgImage: croppedCGImage,
            scale: self.imageRendererFormat.scale,
            orientation: self.imageOrientation
        )
    }
    
}
