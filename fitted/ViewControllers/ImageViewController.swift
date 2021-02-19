//
//  ImageViewController.swift
//  fitted
//
//  Created by Yannick Lawler on 24.01.21.
//

import UIKit
import AVKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageButton()
        setupCaptureSession()
    }
    
    func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        imageView.layer.addSublayer(previewLayer)
        previewLayer.frame = imageView.frame
        
    }
    
    fileprivate func setupImageButton() {
        // Do any additional setup after loading the view.
        
        imageButton.layer.cornerRadius = 26
        imageButton.layer.borderWidth = 2
        imageButton.layer.borderColor = UIColor.systemBackground.cgColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
