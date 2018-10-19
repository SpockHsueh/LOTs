//
//  CameraViewController.swift
//  LOTs
//
//  Created by 乃方 on 2018/10/18.
//  Copyright © 2018年 Nia. All rights reserved.
//

import UIKit
import Photos

class CameraViewController: UIViewController {

    let cameraController = CameraController()
    
    @IBOutlet fileprivate var captureButton: UIButton!
    
    ///Displays a preview of the video output generated by the device's cameras.
    @IBOutlet fileprivate var capturePreviewView: UIView!
    @IBOutlet fileprivate var cameraBGView: UIView!
    @IBOutlet fileprivate var buttonBFView: UIView!
    
    ///Allows the user to put the camera in photo mode.
//    @IBOutlet fileprivate var photoModeButton: UIButton!
    @IBOutlet fileprivate var toggleCameraButton: UIButton!
    @IBOutlet fileprivate var toggleFlashButton: UIButton!
    
    
    ///Allows the user to put the camera in video mode.
//    @IBOutlet fileprivate var videoModeButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = true

    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    @IBAction func toggleFlash(_ sender: UIButton) {
    
        if cameraController.flashMode == .on {
            
            cameraController.flashMode = .off
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash Off Icon"), for: .normal)
        
        }
            
        else {
        
            cameraController.flashMode = .on
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash On Icon"), for: .normal)
        
        }
    
    }
    
    @IBAction func switchCameras(_ sender: UIButton) {
        
        
        
        
    }
    
    
}

extension CameraViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        func styleCaptureButton() {
            
            captureButton.layer.borderColor = #colorLiteral(red: 0.8274509804, green: 0.3529411765, blue: 0.4, alpha: 1)
            captureButton.layer.borderWidth = 2
            
            buttonBFView.layer.cornerRadius = min(buttonBFView.frame.width, buttonBFView.frame.height) / 2
            captureButton.layer.cornerRadius = min(captureButton.frame.width, captureButton.frame.height) / 2
            
            buttonBFView.layer.borderColor = #colorLiteral(red: 0.8274509804, green: 0.3529411765, blue: 0.4, alpha: 1)
            buttonBFView.layer.borderWidth = 2
            
        }
        
        func configureCameraController() {
            
            cameraController.prepare { (error) in
                
                if let error = error {
                    
                    print(error)
                    
                }
                
//                try? self.cameraController.displayPreview(on: self.capturePreviewView)

                try? self.cameraController.displayPreview(on: self.capturePreviewView)
                
            }

        }
        
        styleCaptureButton()
        configureCameraController()
        
    }
    
    
    
    
}
