//
//  ViewController.swift
//  CameraPositionChange
//
//  Copyright © 2019, hahnah. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var captureSession: AVCaptureSession? = nil
    var videoDevice: AVCaptureDevice?
    
    var videoLayer: AVCaptureVideoPreviewLayer? = nil
    var reverseButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.setupCaptureSession(withPosition: .front)
        self.setupPreviewLayer()
        self.setupReverseButton()
    }
    
    func setupCaptureSession(withPosition cameraPosition: AVCaptureDevice.Position) {
        self.videoDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: cameraPosition)
        let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio)
        
        self.captureSession = AVCaptureSession()
        
        // add video input to a capture session
        let videoInput = try! AVCaptureDeviceInput(device: self.videoDevice!)
        self.captureSession?.addInput(videoInput)
        
        // add audio input to a capture session
        let audioInput = try! AVCaptureDeviceInput(device: audioDevice!)
        self.captureSession?.addInput(audioInput)
        
        // add capture output
        let captureOutput: AVCaptureMovieFileOutput = AVCaptureMovieFileOutput()
        self.captureSession?.addOutput(captureOutput)
        
        self.captureSession?.startRunning()
    }
    
    func setupPreviewLayer() {
        // preview layer
        self.videoLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        self.videoLayer?.frame = self.view.bounds
        self.videoLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.addSublayer(self.videoLayer!)
    }
    
    func setupReverseButton() {
        // camera-reversing button
        self.reverseButton.frame = CGRect(x: 0, y: 0, width: 300, height: 70)
        self.reverseButton.center = self.view.center
        self.reverseButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.reverseButton.setTitle("Reverse Camera Position", for: .normal)
        self.reverseButton.setTitleColor(UIColor.white, for: .normal)
        self.reverseButton.setTitleColor(UIColor.lightGray, for: .disabled)
        self.reverseButton.addTarget(self, action: #selector(self.onTapReverseButton(sender:)), for: .touchUpInside)
        self.view.addSubview(self.reverseButton)
    }
    
    @objc func onTapReverseButton(sender: UIButton) {
        self.reverseCameraPosition()
    }

    func reverseCameraPosition() {
        self.captureSession?.stopRunning()
        self.captureSession?.inputs.forEach { input in
            self.captureSession?.removeInput(input)
        }
        self.captureSession?.outputs.forEach { output in
            self.captureSession?.removeOutput(output)
        }
        
        let newCameraPosition: AVCaptureDevice.Position = self.videoDevice?.position == .front ? .back : .front
        self.setupCaptureSession(withPosition: newCameraPosition)
        let newVideoLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
        newVideoLayer.frame = self.view.bounds
        newVideoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        // horizontal flip
        UIView.transition(with: self.view, duration: 1.0, options: [.transitionFlipFromLeft], animations: nil, completion: { _ in
            // replace camera preview
            self.view.layer.replaceSublayer(self.videoLayer!, with: newVideoLayer)
            self.videoLayer = newVideoLayer
        })
    }

}

