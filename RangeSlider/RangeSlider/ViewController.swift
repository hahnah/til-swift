import UIKit
import WARangeSlider

class ViewController: UIViewController {
    
    let rangeSlider1: RangeSlider = RangeSlider(frame: CGRect.zero)
    let rangeSlider2: RangeSlider = RangeSlider(frame: CGRect.zero)
    
    var lowerLabel1: UILabel = UILabel(frame: CGRect.zero)
    var upperLabel1: UILabel = UILabel(frame: CGRect.zero)
    var changedLabel1: UILabel = UILabel(frame: CGRect.zero)
    var lowerLabel2: UILabel = UILabel(frame: CGRect.zero)
    var upperLabel2: UILabel = UILabel(frame: CGRect.zero)
    var changedLabel2: UILabel = UILabel(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // range slider 1
        self.rangeSlider1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.6, height: 40)
        self.rangeSlider1.center = CGPoint(x: self.view.center.x, y: self.view.center.y * 0.75)
        self.rangeSlider1.lowerValue = self.rangeSlider1.minimumValue
        self.rangeSlider1.upperValue = self.rangeSlider1.maximumValue
        self.rangeSlider1.updatePreviousValues()
        view.addSubview(rangeSlider1)
        rangeSlider1.addTarget(self, action: #selector(ViewController.rangeSliderValueChanged1(_:)),
                              for: .valueChanged)
        
        // labels for range slider 1
        self.lowerLabel1.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        self.lowerLabel1.center = CGPoint(x: self.lowerLabel1.frame.width * 0.75, y: self.rangeSlider1.center.y + self.rangeSlider1.frame.height)
        self.lowerLabel1.text = String(self.rangeSlider1.lowerValue)
        self.view.addSubview(self.lowerLabel1)
        self.upperLabel1.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        self.upperLabel1.center = CGPoint(x: self.view.frame.width - self.upperLabel1.frame.width * 0.75, y: self.rangeSlider1.center.y + self.rangeSlider1.frame.height)
        self.upperLabel1.text = String(self.rangeSlider1.upperValue)
        self.view.addSubview(self.upperLabel1)
        self.changedLabel1.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        self.changedLabel1.center = CGPoint(x: self.rangeSlider1.center.x, y: self.rangeSlider1.center.y - self.rangeSlider1.frame.height)
        self.view.addSubview(self.changedLabel1)
        
        // range slider 2
        self.rangeSlider2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: 80)
        self.rangeSlider2.center = CGPoint(x: self.view.center.x, y: self.view.center.y * 1.25)
        self.rangeSlider2.minimumValue = -100
        self.rangeSlider2.maximumValue = 100
        self.rangeSlider2.lowerValue = self.rangeSlider2.minimumValue * 0.75
        self.rangeSlider2.upperValue = self.rangeSlider2.maximumValue * 0.75
        self.rangeSlider2.trackTintColor = .orange
        self.rangeSlider2.trackHighlightTintColor = .red
        self.rangeSlider2.thumbTintColor = .cyan
        self.rangeSlider2.thumbBorderColor = .purple
        self.rangeSlider2.thumbBorderWidth = 10.0
        self.rangeSlider2.curvaceousness = 0.5
        self.rangeSlider2.updatePreviousValues()
        view.addSubview(rangeSlider2)
        rangeSlider2.addTarget(self, action: #selector(ViewController.rangeSliderValueChanged2(_:)),
                               for: .valueChanged)
        
        // labels for range slider 2
        self.lowerLabel2.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        self.lowerLabel2.center = CGPoint(x: self.lowerLabel2.frame.width * 0.75, y: self.rangeSlider2.center.y + self.rangeSlider2.frame.height)
        self.lowerLabel2.text = String(self.rangeSlider2.lowerValue)
        self.view.addSubview(self.lowerLabel2)
        self.upperLabel2.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        self.upperLabel2.center = CGPoint(x: self.view.frame.width - self.upperLabel2.frame.width * 0.75, y: self.rangeSlider2.center.y + self.rangeSlider2.frame.height)
        self.upperLabel2.text = String(self.rangeSlider2.upperValue)
        self.view.addSubview(self.upperLabel2)
        self.changedLabel2.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        self.changedLabel2.center = CGPoint(x: self.rangeSlider2.center.x, y: self.rangeSlider2.center.y - self.rangeSlider2.frame.height)
        self.view.addSubview(self.changedLabel2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func rangeSliderValueChanged1(_ rangeSlider: RangeSlider) -> Void {
        if let value = rangeSlider.changedValue {
            self.changedLabel1.text = String(value)
        }
        self.lowerLabel1.text = String(rangeSlider.lowerValue)
        self.upperLabel1.text = String(rangeSlider.upperValue)
        rangeSlider.updatePreviousValues()
    }
    
    @objc func rangeSliderValueChanged2(_ rangeSlider: RangeSlider) -> Void {
        if let value = rangeSlider.changedValue {
            self.changedLabel2.text = String(value)
        }
        self.lowerLabel2.text = String(rangeSlider.lowerValue)
        self.upperLabel2.text = String(rangeSlider.upperValue)
        rangeSlider.updatePreviousValues()
    }

}

