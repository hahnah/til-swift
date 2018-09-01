import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closeButton: UIButton = UIButton(frame: self.view.frame)
        closeButton.layer.position = self.view.layer.position
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(UIColor.white, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        closeButton.backgroundColor = UIColor.clear
        closeButton.addTarget(self, action: #selector(self.close(_:)), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
