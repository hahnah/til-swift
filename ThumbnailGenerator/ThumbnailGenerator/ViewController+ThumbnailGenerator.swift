import UIKit

extension ViewController {
    
    func generateThumbnail(sourceImage: CGImage, objectiveEdgeLength: CGFloat) -> CGImage {
        let sourceUIImage: UIImage = UIImage(cgImage: sourceImage)
        let thumbnailUIImage: UIImage = self.generateThumbnail(sourceImage: sourceUIImage, objectiveEdgeLength: objectiveEdgeLength)
        let thumbnailCGImage: CGImage = thumbnailUIImage.cgImage!
        return thumbnailCGImage
    }
    
    func generateThumbnail(sourceImage: UIImage, objectiveEdgeLength: CGFloat) -> UIImage {
        let resizedWidth: CGFloat = calculateResizedWidth(sourceImage: sourceImage, objectiveLengthOfShortSide: objectiveEdgeLength)
        let resizedImage: UIImage = resizeImage(sourceImage: sourceImage, objectiveWidth: resizedWidth)
        let thumbnailSize: CGSize = CGSize(width: objectiveEdgeLength, height: objectiveEdgeLength)
        let croppingRect: CGRect = calulateCroppingRect(imgae: resizedImage, objectiveSize: thumbnailSize)
        let croppedImage: UIImage = cropImage(image: resizedImage, croppingRect: croppingRect)
        return croppedImage
    }
    
    func calculateResizedWidth(sourceImage: UIImage, objectiveLengthOfShortSide: CGFloat) -> CGFloat {
        let width: CGFloat = sourceImage.size.width
        let height: CGFloat = sourceImage.size.height
        let resizedWidth: CGFloat = width <= height ? objectiveLengthOfShortSide : objectiveLengthOfShortSide * width / height
        return resizedWidth
    }
    
    func resizeImage(sourceImage: UIImage, objectiveWidth: CGFloat) -> UIImage {
        let aspectScale: CGFloat = sourceImage.size.height / sourceImage.size.width
        let resizedSize: CGSize = CGSize(width: objectiveWidth, height: objectiveWidth * aspectScale)
        
        // リサイズ後のUIImageを生成して返却
        UIGraphicsBeginImageContext(resizedSize)
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
    
    func calulateCroppingRect(imgae: UIImage, objectiveSize: CGSize) -> CGRect {
        let croppingRect: CGRect = CGRect.init(x: (imgae.size.width - objectiveSize.width) / 2, y: (imgae.size.height - objectiveSize.height) / 2, width: objectiveSize.width, height: objectiveSize.height)
        return croppingRect
    }
    
    func cropImage(image: UIImage, croppingRect: CGRect) -> UIImage {
        let croppingRef: CGImage? = image.cgImage!.cropping(to: croppingRect)
        let croppedImage: UIImage = UIImage(cgImage: croppingRef!)
        return croppedImage
    }
    
}
