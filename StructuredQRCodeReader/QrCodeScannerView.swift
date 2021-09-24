//
//  QrCodeScannerView.swift
//  StructuredQRCodeReader
//
//  Created by kazuhiro nanko on 2021/09/23.
//

import AVFoundation
import UIKit

class QrCodeScannerView: UIView {

    weak var delegate: AVCaptureMetadataOutputObjectsDelegate? {
        didSet {
            metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
        }
    }
    var supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.qr]

    private let session = AVCaptureSession()
    private let metadataOutput = AVCaptureMetadataOutput()
    private lazy var cameraView = CameraPreview(session: session, frame: frame)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        checkCameraAuthorizationStatus(cameraView)
        addSubview(cameraView)
    }
    
    private func setupCamera(_ uiView: CameraPreview) {
        if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
            if let input = try? AVCaptureDeviceInput(device: backCamera) {
                session.sessionPreset = .photo

                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(metadataOutput) {
                    session.addOutput(metadataOutput)

                    metadataOutput.metadataObjectTypes = supportedBarcodeTypes
                }
                let previewLayer = AVCaptureVideoPreviewLayer(session: session)

                uiView.backgroundColor = UIColor.gray
                previewLayer.videoGravity = .resizeAspectFill
                uiView.layer.addSublayer(previewLayer)
                uiView.previewLayer = previewLayer
            }
        }
    }
    
    func startSession() {
        session.startRunning()
    }

    func stopSession() {
        session.stopRunning()
    }

    private func checkCameraAuthorizationStatus(_ uiView: CameraPreview) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if cameraAuthorizationStatus == .authorized {
            setupCamera(uiView)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.sync {
                    if granted {
                        self.setupCamera(uiView)
                    }
                }
            }
        }
    }
}
