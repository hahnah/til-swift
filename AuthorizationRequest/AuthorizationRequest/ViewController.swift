import UIKit
import Photos

class ViewController: UIViewController {
    
    let imageName: String = "burger.jpg"
    let imageURL: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "burger", ofType: "jpg")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Just shows the image.
        let image: UIImage = UIImage(named: self.imageName)!
        let imageView: UIImageView = UIImageView(image: image)
        let imageAspect: CGFloat = image.size.height / image.size.width
        imageView.frame = CGRect(x: self.view.bounds.width * 0.05, y: self.view.bounds.height * 0.2, width: self.view.bounds.width * 0.9, height: self.view.bounds.width * 0.9 * imageAspect)
        self.view.addSubview(imageView)
        
        // save button
        let saveButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 60))
        saveButton.center = CGPoint(x: self.view.center.x, y: self.view.bounds.height * 0.85)
        saveButton.tintColor = UIColor.white
        saveButton.backgroundColor = UIColor.red
        saveButton.setTitle("Save Image", for: .normal)
        saveButton.addTarget(self, action: #selector(self.checkAuthorization(sender:)), for: .touchUpInside)
        self.view.addSubview(saveButton)
    }
    
    @objc func checkAuthorization(sender: UIButton) {
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    self.saveImageToPhotos(fromURL: self.imageURL)
                } else if status == .denied {
                    let title: String = "Failed to save image"
                    let message: String = "Allow this app to access Photos."
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { (_) -> Void in
                        guard let settingsURL = URL(string: UIApplication.openSettingsURLString ) else {
                            return
                        }
                        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                    })
                    let closeAction: UIAlertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                    alert.addAction(settingsAction)
                    alert.addAction(closeAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            self.saveImageToPhotos(fromURL: self.imageURL)
        }
    }
    
    func saveImageToPhotos(fromURL atURL: URL) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: atURL)
        }) { saved, error in
            let success = saved && (error == nil)
            let title = success ? "Success" : "Error"
            let message = success ? "Image saved." : "Failed to save image."
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
