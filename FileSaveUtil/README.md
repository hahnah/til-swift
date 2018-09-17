# File Save Utility

**This utility suports only movie export so far.**

## Usage

### Export movie

Call `FileSaveUtility.exportMovie(sourceURL:, destinationURL:, fileType:)`method to export movie.

#### Sapmle

```swift
let filePath: String = Bundle.main.path(forResource: "sample", ofType: "mov")!
let sourceURL: URL = URL(fileURLWithPath: filePath, relativeTo: nil)
        
let documentsDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
let destinationURL: URL = documentsDirectory.appendingPathComponent("myMovie.mov")

let fileType: AVFileType = AVFileType.mov

FileSaveUtility.exportMovie(sourceURL: sourceURL, destinationURL: destinationURL, fileType: fileType)
```

## License

MIT © [hahnah](https://superhahnah.com)