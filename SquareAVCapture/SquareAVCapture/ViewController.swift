import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {
    let fileOutput = AVCaptureMovieFileOutput()
    
    var recordButton: UIButton!
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.setUpCamera()
    }
    
    func setUpCamera() {
        let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio)
        let captureSession = AVCaptureSession()
        
        // 映像入力を設定
        let videoInput = try! AVCaptureDeviceInput(device: videoDevice!)
        captureSession.addInput(videoInput)
        
        // 音声入力を設定
        let audioInput = try! AVCaptureDeviceInput(device: audioDevice!)
        captureSession.addInput(audioInput)
        
        // 動画の最大時間を 60秒 に設定
        self.fileOutput.maxRecordedDuration = CMTimeMake(value: 60, timescale: 1)
        captureSession.addOutput(fileOutput)
        
        // 正方形のプレビュー
        let videoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoLayer.frame = CGRect(x: 0, y: (self.view.bounds.height - self.view.bounds.width) / 2, width: self.view.bounds.width, height: self.view.bounds.width)
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.addSublayer(videoLayer)
        
        // カメラ(とマイク)のセッションを開始
        captureSession.startRunning()
        
        // 録画ボタンを配置
        self.recordButton = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
        self.recordButton.backgroundColor = UIColor.gray
        self.recordButton.layer.masksToBounds = true
        self.recordButton.setTitle("Record", for: .normal)
        self.recordButton.layer.cornerRadius = 20
        self.recordButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y:self.view.bounds.height - 100)
        self.recordButton.addTarget(self, action: #selector(self.onClickRecordButton(sender:)), for: .touchUpInside)
        self.view.addSubview(recordButton)
    }
    
    @objc func onClickRecordButton(sender: UIButton) {
        if !self.isRecording {
            // 録画を開始
            let tempDirectory: URL = URL(fileURLWithPath: NSTemporaryDirectory())
            let fileURL: URL = tempDirectory.appendingPathComponent("mytemp1.mov")
            fileOutput.startRecording(to: fileURL, recordingDelegate: self)
            
            self.isRecording = true
            self.recordButton.backgroundColor = .red
            self.recordButton.setTitle("●Recording", for: .normal)
        } else {
            // 録画を終了
            fileOutput.stopRecording()
            
            self.isRecording = false
            self.recordButton.backgroundColor = .gray
            self.recordButton.setTitle("Record", for: .normal)
        }
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        let tempDirectory: URL = URL(fileURLWithPath: NSTemporaryDirectory())
        let croppedMovieFileURL: URL = tempDirectory.appendingPathComponent("mytemp2.mov")
        
        // 録画された動画を正方形にクロッピングする
        MovieCropper.exportSquareMovie(sourceURL: outputFileURL, destinationURL: croppedMovieFileURL, fileType: .mov, completion: {
            // 正方形にクロッピングされた動画をフォトライブラリに保存
            self.saveToPhotoLibrary(fileURL: croppedMovieFileURL)
        })
    }
    
    func saveToPhotoLibrary(fileURL: URL) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: fileURL)
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
