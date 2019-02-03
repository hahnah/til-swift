//
//  ViewController.swift
//  CameraZoom
//
//  Copyright © 2019, hahnah. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var videoDevice: AVCaptureDevice?
    private var captureSession: AVCaptureSession? = nil
    private var videoLayer: AVCaptureVideoPreviewLayer? = nil
    
    private var baseZoomFanctor: CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCamera()
        self.setupPinchGestureRecognizer()
    }
    
    private func setupCamera() {
        self.videoDevice = AVCaptureDevice.default(for: .video)
        let audioDevice = AVCaptureDevice.default(for: .audio)
        
        self.captureSession = AVCaptureSession()
        
        // add video input to a capture session
        let videoInput = try! AVCaptureDeviceInput(device: self.videoDevice!)
        self.captureSession?.addInput(videoInput)
        
        // add audio input to a capture session
        let audioInput = try! AVCaptureDeviceInput(device: audioDevice!)
        self.captureSession?.addInput(audioInput)
        
        // preview layer
        self.videoLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        self.videoLayer?.frame = self.view.bounds
        self.videoLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.addSublayer(self.videoLayer!)
        
        self.captureSession?.startRunning()
    }
    
    private func setupPinchGestureRecognizer() {
        // pinch recognizer for zooming
        let pinchGestureRecognizer: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.onPinchGesture(_:)))
        self.view.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    @objc private func onPinchGesture(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began {
            self.baseZoomFanctor = (self.videoDevice?.videoZoomFactor)!
        }
        
        let tempZoomFactor: CGFloat = self.baseZoomFanctor * sender.scale
        let newZoomFactdor: CGFloat
        if tempZoomFactor < (self.videoDevice?.minAvailableVideoZoomFactor)! {
            newZoomFactdor = (self.videoDevice?.minAvailableVideoZoomFactor)!
        } else if (self.videoDevice?.maxAvailableVideoZoomFactor)! < tempZoomFactor {
            newZoomFactdor = (self.videoDevice?.maxAvailableVideoZoomFactor)!
        } else {
            newZoomFactdor = tempZoomFactor
        }
        
        do {
            try self.videoDevice?.lockForConfiguration()
            self.videoDevice?.ramp(toVideoZoomFactor: newZoomFactdor, withRate: 32.0)
            self.videoDevice?.unlockForConfiguration()
        } catch {
            print("Failed to change zoom factor.")
        }
    }


}

