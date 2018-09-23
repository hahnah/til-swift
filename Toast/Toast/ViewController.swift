import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toastButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        toastButton.center = CGPoint(x: self.view.center.x, y: self.view.bounds.height * 0.7)
        toastButton.tintColor = UIColor.white
        toastButton.backgroundColor = UIColor.blue
        toastButton.setTitle("PRINT", for: .normal)
        toastButton.addTarget(self, action: #selector(self.toastButtonDidTapped(_:)), for: .touchUpInside)
        self.view.addSubview(toastButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func toastButtonDidTapped(_ sender: UIButton) {
        showToast(onView: self.view, message: "Can you see me?")
    }

    func showToast(onView superView: UIView, message: String) {
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 280, height: 90))
        toastLabel.center = superView.center
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        superView.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}
