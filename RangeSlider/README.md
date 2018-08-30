# Range Slider

## Summary

A simple range slider sample in Swift4.

This Sample depends on [WARangeSlider](https://github.com/warchimede/RangeSlider/tree/master) and provides a little bit extension of that.

## Clone and install dependency

```
$ git clone https://github.com/hahnah/til-swift.git
$ cd til-swift
$ git checkout -b til-swift origin/til-swift
$ pod install
```

## Use range slider

```swift
let rangeSlider: RangeSlider = RangeSlider(frame: yourFrame)
view.addSubview(rangeSlider)
rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)), for: .valueChanged)
```

## Configuration

[WARangeSlider 1.1.1](https://github.com/warchimede/RangeSlider/tree/1.1.1) (at the moment) provides properties to customize the slider and access its information.

> The range slider can be customized and information can be accessed through these properties :
+ `minimumValue` : The minimum possible value of the range
+ `maximumValue` : The maximum possible value of the range
+ `lowerValue` : The value corresponding to the left thumb current position
+ `upperValue` : The value corresponding to the right thumb current position
+ `trackTintColor` : The track color
+ `trackHighlightTintColor` : The color of the section of the track located between the two thumbs
+ `thumbTintColor`: The thumb color
+ `thumbBorderColor`: The thumb border color
+ `thumbBorderWidth`: The width of the thumb border
+ `curvaceousness` : From 0.0 for square thumbs to 1.0 for circle thumbs

## Extension

[The extension](https://github.com/hahnah/til-swift/blob/range-slider/RangeSlider/RangeSlider/RangeSlider%2BChangedValue.swift) of range slider provides a property to access an impormation. 

+ `changedValue` : The value corresponding to the changed thumb current position

#### Sample

You can access `changedValue` as below.

```swift
@objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) -> Void {
    if let value = rangeSlider.changedValue {
        // CODE
        print(value)
    }
    rangeSlider.updatePreviousValues()
}
```

## License

MIT © [hahnah](https://superhahnah.com)