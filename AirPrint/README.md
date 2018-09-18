# AirPrint

A Sample iOS Project of AirPrint.

## Code

`ViewController.showPrinterView(_:)` method shows how to AirPrint an image by `UIPrintInteractionController` instance.

```swift
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
```

## License

MIT © [hahnah](https://superhahnah.com)