//
//  Extension+UIImage.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/4/21.
//

import Foundation
import UIKit

extension UIImage {
    static var emailImage: UIImage {
        return UIImage(systemName: "envelope.fill") ?? UIImage.remove
    }

    static var phoneImage: UIImage {
        return UIImage(systemName: "phone.fill") ?? UIImage.remove
    }

    static var editImage: UIImage {
        return UIImage(named: "edit-button-placeholder") ?? UIImage.remove
    }

    static var backgroundProfile: UIImage {
        return UIImage(named: "profile-background") ?? UIImage.remove
    }

    static var chevronDown: UIImage {
        return UIImage(named: "chevron-down") ?? UIImage.remove
    }
    
    static var chevronDownKotak: UIImage {
        return UIImage(named: "chevron-down-kotak") ?? UIImage.remove
    }
    static var chevronUpKotak: UIImage {
        return UIImage(named: "chevron-up-kotak") ?? UIImage.remove
    }
}

extension UIImage {
    public convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }

    public convenience init?(named name: String, bundle: Bundle) {
        self.init(named: name, in: bundle, compatibleWith: nil)
    }

    public func transform(withNewColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage!)

        color.setFill()
        context.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    // MARK: - UIImage+Resize

    public func fixOrientation() -> UIImage {
        if imageOrientation == UIImage.Orientation.up {
            return self
        }

        var transform = CGAffineTransform.identity

        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: .pi)

        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)

        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -.pi / 2)

        case .up, .upMirrored:
            break

        @unknown default:
            break
        }

        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        default:
            break
        }

        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        guard let cgImage = self.cgImage else {
            return self
        }
        guard let colorSpace = cgImage.colorSpace else {
            return self
        }
        guard let context = CGContext(
            data: nil,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: UInt32(cgImage.bitmapInfo.rawValue)
        ) else {
            return self
        }

        context.concatenate(transform)

        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }

        // And now we just create a new UIImage from the drawing context
        guard let newCGImage = context.makeImage() else {
            return self
        }
        let image = UIImage(cgImage: newCGImage)

        return image
    }

    @objc public func compressImageData(maxSizeInMB: Int) -> Data? {
        let image = fixOrientation()
        let sizeInBytes = maxSizeInMB * 1024 * 1024
        var needCompress: Bool = true
        var imgData: Data?
        var compressingValue: CGFloat = 1.0
        while needCompress, compressingValue > 0.0 {
            if let data: Data = image.jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }

        if let data = imgData {
            if data.count < sizeInBytes {
                return data
            }
        }
        return image.jpegData(compressionQuality: 1)
    }

    public func resizedImage(to dstSize: CGSize) -> UIImage? {
        var dstSize = dstSize
        guard let imgRef = cgImage else { return nil }
        let srcSize = CGSize(width: imgRef.width, height: imgRef.height)
        if srcSize.equalTo(dstSize) {
            return self
        }
        let scaleRatio = dstSize.width / srcSize.width
        let orient = imageOrientation
        var transform: CGAffineTransform = .identity
        switch orient {
        case .up:
            transform = .identity
        case .upMirrored:
            transform = CGAffineTransform(translationX: srcSize.width, y: 0.0)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
        case .down:
            transform = CGAffineTransform(translationX: srcSize.width, y: srcSize.height)
            transform = transform.rotated(by: .pi)
        case .downMirrored:
            transform = CGAffineTransform(translationX: 0.0, y: srcSize.height)
            transform = transform.scaledBy(x: 1.0, y: -1.0)
        case .leftMirrored:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(translationX: srcSize.height, y: srcSize.width)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
            transform = transform.rotated(by: CGFloat(3.0 * Double.pi / 2))
        case .left:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(translationX: 0.0, y: srcSize.width)
            transform = transform.rotated(by: CGFloat(3.0 * Double.pi / 2))
        case UIImage.Orientation.rightMirrored:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case UIImage.Orientation.right:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(translationX: srcSize.height, y: 0.0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        default:
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(dstSize, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        if orient == .right || orient == .left {
            context.scaleBy(x: -scaleRatio, y: scaleRatio)
            context.translateBy(x: -srcSize.height, y: 0)
        } else {
            context.scaleBy(x: scaleRatio, y: -scaleRatio)
            context.translateBy(x: 0, y: -srcSize.height)
        }
        context.concatenate(transform)
        context.draw(imgRef, in: CGRect(x: 0, y: 0, width: srcSize.width, height: srcSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

