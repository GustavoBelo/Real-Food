//
//  CatchRestaurantNameViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 09/12/21.
//

import UIKit
import AVFoundation
import Firebase

class CatchRestaurantNameViewController: UIViewController {
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var scannerView: UIView!
    private var scanner: Scanner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        self.scanner = Scanner(withDelegate: self)
        scanner?.requestCaptureSessionStartRunning()
    }    
}

extension CatchRestaurantNameViewController: AVCaptureMetadataOutputObjectsDelegate, ScannerDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection) {
        self.scanner?.metadataOutput(output,
                                     didOutput: metadataObjects,
                                     from: connection)
    }
    
    func cameraView() -> UIView {
        return self.scannerView
    }
    
    func delegateViewController() -> UIViewController {
        return self
    }
    
    func scanCompleted(withCode code: String) {
        let controller = storyboard?.instantiateViewController(withIdentifier: HomeViewController.identifier) as! UIViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical
        controller.title = code
        return present(controller, animated: true)
    }
    
}
