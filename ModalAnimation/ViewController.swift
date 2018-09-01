import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coverVerticalModalButton: UIButton = UIButton(frame: CGRect(x: 0, y: self.view.bounds.height * 0, width: self.view.frame.width, height: self.view.bounds.height * 0.25))
        coverVerticalModalButton.setTitle("coverVertical", for: .normal)
        coverVerticalModalButton.setTitleColor(UIColor.white, for: .normal)
        coverVerticalModalButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        coverVerticalModalButton.backgroundColor = UIColor.red
        coverVerticalModalButton.addTarget(self, action: #selector(self.showSecondView(_:)), for: .touchUpInside)
        self.view.addSubview(coverVerticalModalButton)
        
        let crossDissolveModalButton: UIButton = UIButton(frame: CGRect(x: 0, y: self.view.bounds.height * 0.25, width: self.view.frame.width, height: self.view.bounds.height * 0.25))
        crossDissolveModalButton.setTitle("crossDissolve", for: .normal)
        crossDissolveModalButton.setTitleColor(UIColor.white, for: .normal)
        crossDissolveModalButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        crossDissolveModalButton.backgroundColor = UIColor.orange
        crossDissolveModalButton.addTarget(self, action: #selector(self.showSecondView(_:)), for: .touchUpInside)
        self.view.addSubview(crossDissolveModalButton)
        
        let flipHorizontalButton: UIButton = UIButton(frame: CGRect(x: 0, y: self.view.bounds.height * 0.5, width: self.view.frame.width, height: self.view.bounds.height * 0.25))
        flipHorizontalButton.setTitle("flipHorizontal", for: .normal)
        flipHorizontalButton.setTitleColor(UIColor.white, for: .normal)
        flipHorizontalButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        flipHorizontalButton.backgroundColor = UIColor.brown
        flipHorizontalButton.addTarget(self, action: #selector(self.showSecondView(_:)), for: .touchUpInside)
        self.view.addSubview(flipHorizontalButton)
        
        let partialCurlButton: UIButton = UIButton(frame: CGRect(x: 0, y: self.view.bounds.height * 0.75, width: self.view.frame.width, height: self.view.bounds.height * 0.25))
        partialCurlButton.setTitle("partialCurl", for: .normal)
        partialCurlButton.setTitleColor(UIColor.white, for: .normal)
        partialCurlButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        partialCurlButton.backgroundColor = UIColor.blue
        partialCurlButton.addTarget(self, action: #selector(self.showSecondView(_:)), for: .touchUpInside)
        self.view.addSubview(partialCurlButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func showSecondView(_ sender: UIButton) {
        let secondViewController = SecondViewController()
        secondViewController.view.backgroundColor = sender.backgroundColor

        switch sender.title(for: .normal) {
        case "coverVertical":
            secondViewController.modalTransitionStyle = .coverVertical
        case "crossDissolve":
            secondViewController.modalTransitionStyle = .crossDissolve
        case "flipHorizontal":
            secondViewController.modalTransitionStyle = .flipHorizontal
        case "partialCurl":
            secondViewController.modalTransitionStyle = .partialCurl
        default:
            secondViewController.modalTransitionStyle = .coverVertical
        }
        
        self.present(secondViewController, animated: true, completion: nil)
    }
    
}
