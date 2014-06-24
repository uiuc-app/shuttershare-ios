//
//  CameraViewController.swift
//  shuttershare
//
//  Created by Yosub Shin on 6/21/14.
//  Copyright (c) 2014 yosubshin. All rights reserved.
//
// Referred http://x-code-tutorials.com/2013/08/03/live-camera-preview-and-capture/

import UIKit
import AVFoundation
import CoreMedia

class CameraViewController: UIViewController {

    @IBOutlet var captureImage: UIImageView
    @IBOutlet var imagePreview: UIView
    var stillImageOutput: AVCaptureStillImageOutput!
    var isFrontCamera : Bool!
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func takeImage(sender: AnyObject) {
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isFrontCamera = false
        self.captureImage.hidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.initializeCamera()
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    func initializeCamera() {
        var session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetPhoto
        var captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        captureVideoPreviewLayer.frame = self.imagePreview.bounds
        self.imagePreview.layer.addSublayer(captureVideoPreviewLayer)
        
        var view = self.imagePreview
        var viewLayer = view.layer
        viewLayer.masksToBounds = true
        
        var bounds = view.bounds
        captureVideoPreviewLayer.frame = bounds
        
        var devices = AVCaptureDevice.devices()
        var frontCamera: AVCaptureDevice?
        var backCamera: AVCaptureDevice?
        
        for device in devices as AVCaptureDevice[] {
            NSLog("Device name: \(device.localizedName)")
            if device.hasMediaType(AVMediaTypeVideo) {
                if device.position == AVCaptureDevicePosition.Back {
                    NSLog("Device position: back")
                    backCamera = device
                } else {
                    NSLog("Device position: front")
                    frontCamera = device
                }
            }
        }
        
        var currentCamera = isFrontCamera ? frontCamera : backCamera
        
        var error: NSError?
        var input : AVCaptureInput! = AVCaptureDeviceInput.deviceInputWithDevice(currentCamera, error: &error) as AVCaptureInput
        
        if !input {
            NSLog("Error: could not open camera: \(error)")
        }
        session.addInput(input)
        
        self.stillImageOutput = AVCaptureStillImageOutput()
        var outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
        stillImageOutput.outputSettings = outputSettings

        session.addOutput(stillImageOutput)
        session.startRunning()
    }
    
    func takeImage() {
        var videoConnection : AVCaptureConnection? = nil
        for connection in stillImageOutput.connections as AVCaptureConnection[] {
            for port in connection.inputPorts as AVCaptureInputPort[] {
                if port.mediaType == AVMediaTypeVideo {
                    videoConnection = connection
                    break
                }
            }
            if videoConnection {
                break
            }
        }
        
        NSLog("About to request a capture from \(stillImageOutput)")
        
        stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(imageSampleBuffer, error) in
            if imageSampleBuffer {
                var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer as CMSampleBuffer)
                self.processImage(UIImage(data: imageData))
            }
            })
    }
    
    func processImage(image: UIImage!) {
        NSLog("Processing image \(image)")
    }
    
}
