import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {
    let fileOutput = AVCaptureMovieFileOutput()
    
    var recordButton: UIButton!
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCameraPreview()
    }
    
    func showCameraPreview() {
        let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio)
        
        do {
            if videoDevice == nil || audioDevice == nil {
                throw NSError(domain: "device error", code: -1, userInfo: nil)
            }
            let captureSession = AVCaptureSession()
            
            // video inputを capture sessionに追加
            let videoInput = try AVCaptureDeviceInput(device: videoDevice!)
            captureSession.addInput(videoInput)
            
            // audio inputを capture sessionに追加
            let audioInput = try AVCaptureDeviceInput(device: audioDevice!)
            captureSession.addInput(audioInput)
            
            // max 30sec
            self.fileOutput.maxRecordedDuration = CMTimeMake(value: 30, timescale: 1)
            captureSession.addOutput(fileOutput)
            
            // プレビュー
            let videoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoLayer.frame = self.view.bounds
            videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.view.layer.addSublayer(videoLayer)
            
            captureSession.startRunning()
            
            setUpButton()
        } catch {
            // エラー処理
        }
    }
    
    func setUpButton() {
        recordButton = UIButton(frame: CGRect(x: 0,y: 0,width: 120,height: 50))
        recordButton.backgroundColor = UIColor.gray
        recordButton.layer.masksToBounds = true
        recordButton.setTitle("Record", for: .normal)
        recordButton.layer.cornerRadius = 20.0
        recordButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
        recordButton.addTarget(self, action: #selector(self.onClickRecordButton(sender:)), for: .touchUpInside)
        
        self.view.addSubview(recordButton)
    }
    
    @objc func onClickRecordButton(sender: UIButton) {
        if !isRecording {
            // 録画開始
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0] as String
            let filePath : String? = "\(documentsDirectory)/temp.mp4"
            let fileURL : NSURL = NSURL(fileURLWithPath: filePath!)
            fileOutput.startRecording(to: fileURL as URL, recordingDelegate: self)
            
            isRecording = true
            changeButtonColor(target: recordButton, color: UIColor.red)
            recordButton.setTitle("●Recording", for: .normal)
        } else {
            // 録画終了
            fileOutput.stopRecording()
            
            isRecording = false
            changeButtonColor(target: recordButton, color: UIColor.gray)
            recordButton.setTitle("Record", for: .normal)
        }
    }
    
    func changeButtonColor(target: UIButton, color: UIColor) {
        target.backgroundColor = color
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        //self.requestAuthorizationOfPhotoLibraryUsege()
        
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    self.saveMovieToPhotos(fromURL: outputFileURL)
                } else if status == .denied {
                    let title: String = "Failed to save video"
                    let message: String = "Allow this app to access Photos."
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { (_) -> Void in
                        guard let settingsURL = URL(string: UIApplication.openSettingsURLString ) else {
                            return
                        }
                        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                    })
                    let closeAction: UIAlertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                    alert.addAction(settingsAction)
                    alert.addAction(closeAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            self.saveMovieToPhotos(fromURL: outputFileURL)
        }
    }
    
    func saveMovieToPhotos(fromURL atURL: URL) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: atURL)
        }) { saved, error in
            let success = saved && (error == nil)
            let title = success ? "Success" : "Error"
            let message = success ? "Video saved." : "Failed to save video."
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
