import UIKit

class ViewController: UIViewController {
    
    var printingImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // image
        self.printingImage = UIImage(named: "sampleImage.png")
        let imageView: UIImageView = UIImageView(image: self.printingImage)
        let imageAspect: CGFloat = (self.printingImage?.size.height)! / (self.printingImage?.size.width)!
        imageView.frame = CGRect(x: self.view.bounds.width * 0.05, y: self.view.bounds.height * 0.1, width: self.view.bounds.width * 0.9, height: self.view.bounds.width * 0.9 * imageAspect)
        self.view.addSubview(imageView)
        
        // toolbar
        self.view.isOpaque = false
        let toolbarHeight: CGFloat = 80
        let toolbarPaddingBottom: CGFloat = 20
        let toolbarRect: CGRect = CGRect(x: 0, y: self.view.bounds.height - toolbarHeight - toolbarPaddingBottom, width: self.view.bounds.width, height: toolbarHeight)
        let toolbar: UIToolbar = UIToolbar(frame: toolbarRect)
        let activityButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.showActivityView(_:)))
        let buttonGap: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.items = [buttonGap, activityButton, buttonGap]
        self.view.addSubview(toolbar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func showActivityView(_ sender: UIBarButtonItem) -> Void {
        let activityItems: Array<Any> = [self.printingImage!]
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        let excludedActivityTypes: Array<UIActivityType> = [
            // UIActivityType.addToReadingList,
            // UIActivityType.airDrop,
            // UIActivityType.assignToContact,
            // UIActivityType.copyToPasteboard,
            // UIActivityType.mail,
            // UIActivityType.message,
            // UIActivityType.openInIBooks,
            // UIActivityType.postToFacebook,
            UIActivityType.postToFlickr,
            UIActivityType.postToTencentWeibo
            // UIActivityType.postToTwitter,
            // UIActivityType.postToVimeo,
            // UIActivityType.postToWeibo,
            // UIActivityType.print,
            // UIActivityType.saveToCameraRoll,
            // UIActivityType.markupAsPDF
        ]
        activityViewController.excludedActivityTypes = excludedActivityTypes
        
        activityViewController.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, activityError: Error?) in
            
            guard completed else { return }
            
            switch activityType {
            case UIActivityType.postToTwitter:
                print("Tweeted")
            case UIActivityType.print:
                print("Printed")
            case UIActivityType.saveToCameraRoll:
                print("Saved to Camera Roll")
            default:
                print("Done")
            }
        }
        
        self.present(activityViewController, animated: true, completion: nil)
    }

}
