//
//  CameraController.swift
//  LOTs
//
//  Created by 乃方 on 2018/10/18.
//  Copyright © 2018年 Nia. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

extension CameraController {
    
    enum CameraControllerError: Swift.Error {
        
        case captureSessionAlreadyRunning
        case captureSessionIsMissing
        case inputsAreInvalid
        case invalidOperation
        case noCamerasAvailable
        case unknown
        
    }
    
    public enum CameraPosition {
        
        case front
        case rear
    
    }
    
}

class CameraController {
    
    var captureSession: AVCaptureSession?
    
    var currentCameraPosition: CameraPosition?

    var frontCamera: AVCaptureDevice?
    var rearCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?

    var frontCameraInput: AVCaptureDeviceInput?
    var rearCameraInput: AVCaptureDeviceInput?
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var flashMode = AVCaptureDevice.FlashMode.off
    
    func prepare(completionHandler: @escaping (Error?) -> Void) {
        
        func createCaptureSession() {
                    
            self.captureSession = AVCaptureSession()

        }
        
        func configureCaptureDevices() throws {
            
            // Check if there is camera for usage
            let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .unspecified)
            let cameras = session.devices.compactMap { $0 }
            
            guard !cameras.isEmpty else { throw CameraControllerError.noCamerasAvailable }
            
            // Identify the camera status
            for camera in cameras {
                
                if camera.position == .front {
                    
                    self.frontCamera = camera
                
                }
                
                if camera.position == .back {
                
                    self.rearCamera = camera
                    
                    try camera.lockForConfiguration()
                    camera.focusMode = .continuousAutoFocus
                    camera.unlockForConfiguration()
                
                }
            
            }
            
        }
        
        func configureDeviceInputs() throws {
            
            // Check if captureSession available
            guard let captureSession = self.captureSession else { throw
                
                CameraControllerError.captureSessionIsMissing }
            
            // Capture session
            if let rearCamera = self.rearCamera {
                
                self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
                
                if captureSession.canAddInput(self.rearCameraInput!) { captureSession.addInput(self.rearCameraInput!) }
                
                self.currentCameraPosition = .rear
            
            } else if let frontCamera = self.frontCamera {
            
                self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
                
                if captureSession.canAddInput(self.frontCameraInput!) { captureSession.addInput(self.frontCameraInput!) }
                else { throw CameraControllerError.inputsAreInvalid }
                
                self.currentCameraPosition = .front
                
            }
                
            else { throw CameraControllerError.noCamerasAvailable }
            
        }
        
        func configurePhotoOutput() throws {
            
            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
            
            self.photoOutput = AVCapturePhotoOutput()
            
            self.photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            
            if captureSession.canAddOutput(self.photoOutput!) { captureSession.addOutput(self.photoOutput!) }
            
            captureSession.startRunning()
            
        }
        
        DispatchQueue(label: "prepare").async {
            
            do {
                
                createCaptureSession()
                try configureCaptureDevices()
                try configureDeviceInputs()
                try configurePhotoOutput()
            
            }
                
            catch {
            
                DispatchQueue.main.async {
                
                    completionHandler(error)
                
                }
                
                return
            }
            
            DispatchQueue.main.async {
                
                completionHandler(nil)
            
            }
        }
        
    }
    
    func displayPreview(on view: UIView) throws {
        
        guard let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = .portrait
        
        view.layer.insertSublayer(self.previewLayer!, at: 0)
        
//        self.previewLayer?.frame = view.frame

        self.previewLayer?.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)

        //        self.previewLayer?.frame = view.frame
        
    }

    func switchCameras() throws {
        
        // Check the available capture session during change the camera
        guard let currentCameraPosition = currentCameraPosition, let captureSession = self.captureSession, captureSession.isRunning else {
                throw CameraControllerError.captureSessionIsMissing
        }

        captureSession.beginConfiguration()
        
        func switchToFrontCamera() throws {
            
            guard let rearCameraInput = self.rearCameraInput, captureSession.inputs.contains(rearCameraInput),
                let frontCamera = self.frontCamera else { throw CameraControllerError.invalidOperation }
            
            self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
            
            captureSession.removeInput(rearCameraInput)
            
            if captureSession.canAddInput(self.frontCameraInput!) {
                
                captureSession.addInput(self.frontCameraInput!)
                
                self.currentCameraPosition = .front
            
            }
                
            else {
            
                throw CameraControllerError.invalidOperation
            
            }
            
        }
        
        func switchToRearCamera() throws {
            
            guard let frontCameraInput = self.frontCameraInput, captureSession.inputs.contains(frontCameraInput),
                let rearCamera = self.rearCamera else { throw CameraControllerError.invalidOperation }
            
            self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
            
            captureSession.removeInput(frontCameraInput)
            
            if captureSession.canAddInput(self.rearCameraInput!) {
                
                captureSession.addInput(self.rearCameraInput!)
                
                self.currentCameraPosition = .rear
            
            } else {
                
                throw CameraControllerError.invalidOperation
                
            }
            
        }
        
        switch currentCameraPosition {
            
        case .front:
            try switchToRearCamera()
            
        case .rear:
            try switchToFrontCamera()
            
        }
        
        captureSession.commitConfiguration()
        
    }
    
}
