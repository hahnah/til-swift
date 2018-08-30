import WARangeSlider

var _previousLowerValue: Double = 0
var _previousUpperValue: Double = 0

extension RangeSlider {
    var previousLowerValue: Double {
        get {
            return (objc_getAssociatedObject(self, &_previousLowerValue) ?? 0) as! Double
        }
        set {
            objc_setAssociatedObject(self, &_previousLowerValue, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    var previousUpperValue: Double {
        get {
            return (objc_getAssociatedObject(self, &_previousUpperValue) ?? 0) as! Double
        }
        set {
            objc_setAssociatedObject(self, &_previousUpperValue, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var lowerValueChanged: Bool {
        get {
            return self.previousLowerValue != self.lowerValue
        }
    }
    
    var upperValueChanged: Bool {
        get {
            return self.previousUpperValue != self.upperValue
        }
    }
    
    var changedValue: Double? {
        get {
            if self.lowerValueChanged {
                return self.lowerValue
            } else if self.upperValueChanged {
                return self.upperValue
            } else {
                return nil
            }
        }
    }
    
    func updatePreviousValues() -> Void {
        self.previousLowerValue = self.lowerValue
        self.previousUpperValue = self.upperValue
    }
}
