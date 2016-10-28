//
//  UIImage+Mask.swift
//  SearchCentricViewController
//
//  Created by Felipe Docil on 10/8/16.
//  Copyright © 2016 Felipe Docil. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension UIImage {
    func mask(maskImage:(UIImage)) -> UIImage? {
        
        let imageReference = self.cgImage
        if let maskReference = maskImage.cgImage,
            let dataProvider = maskReference.dataProvider,
            let imageMask = CGImage(maskWidth: maskReference.width,
                                height: maskReference.height,
                                bitsPerComponent: maskReference.bitsPerComponent,
                                bitsPerPixel: maskReference.bitsPerPixel,
                                bytesPerRow: maskReference.bytesPerRow,
                                provider: dataProvider,
                                decode: nil,
                                shouldInterpolate: false) {
            
            let maskedReference = imageReference?.masking(imageMask)
            
            let maskedImage = UIImage(cgImage:maskedReference!)
            
            return maskedImage
        } else {
            return nil
        }
    }
    
    func invertedMask(image:UIImage, rect:CGRect) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        self.draw(in: rect)
        image.draw(in: rect, blendMode: .destinationOut, alpha: 1)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    static func from(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
