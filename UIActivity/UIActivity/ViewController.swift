import UIKit

class ViewController: UIViewController {
    
    var printingImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.printingImage = UIImage(named: "sampleImage.png")
        let imageView: UIImageView = UIImageView(image: self.printingImage)
        let imageAspect: CGFloat = (self.printingImage?.size.height)! / (self.printingImage?.size.width)!
        imageView.frame = CGRect(x: self.view.bounds.width * 0.05, y: self.view.bounds.height * 0.1, width: self.view.bounds.width * 0.9, height: self.view.bounds.width * 0.9 * imageAspect)
        self.view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

