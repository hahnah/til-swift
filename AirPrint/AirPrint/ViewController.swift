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
        
        let printButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        printButton.center = CGPoint(x: self.view.center.x, y: self.view.bounds.height * 0.9)
        printButton.tintColor = UIColor.white
        printButton.backgroundColor = UIColor.blue
        printButton.setTitle("PRINT", for: .normal)
        printButton.addTarget(self, action: #selector(self.showPrinterView(_:)), for: .touchUpInside)
        self.view.addSubview(printButton)
        
    }
    
    @objc func showPrinterView(_ sender: UIButton) -> Void {
        let printController = UIPrintInteractionController.shared
        
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = UIPrintInfoOutputType.general
        printInfo.jobName = "Print Job"
        printInfo.orientation = .portrait
        
        printController.printInfo = printInfo
        printController.printingItem = self.printingImage
        
        printController.present(animated: true, completionHandler: nil)
    }

}

