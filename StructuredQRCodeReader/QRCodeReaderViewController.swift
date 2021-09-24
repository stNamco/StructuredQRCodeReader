//
//  QRCodeReaderViewController.swift
//  StructuredQRCodeReader
//
//  Created by kazuhiro nanko on 2021/09/24.
//

import UIKit
import Foundation
import AVFoundation

public protocol QrCodeCameraDelegate: class {
    // TODO:
    func readDate(_ dataString: String)
}

public class QRCodeReaderViewController: UIViewController {
        
    private lazy var scannerView = QrCodeScannerView(frame: view.bounds)
    
    public weak var delegate: QrCodeCameraDelegate?
    private(set) var isScanning: Bool = false
    
    public var setting: QRCodeReaderSetting = .init() {
        didSet {
            scannerView.startSession()
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isScanning = true
        scannerView.startSession()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        scannerView.stopSession()
        isScanning = false
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        scannerView.delegate = self
        view.addSubview(scannerView)
    }
    
    private func foundBarcode(_ stringValue: String) {
        let now = Date()
        if now.timeIntervalSince(setting.lastTime) >= setting.scanInterval {
            setting.lastTime = now
            delegate?.readDate(stringValue)
        }
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension QRCodeReaderViewController: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
                
        guard let dataString = QRCodeParser.parse(metadataObjects: metadataObjects) else {
            return
        }
        
        foundBarcode(dataString)
    }
}
