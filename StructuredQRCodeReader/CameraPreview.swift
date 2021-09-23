//
//  CameraPreview.swift
//  StructuredQRCodeReader
//
//  Created by kazuhiro nanko on 2021/09/23.
//

import UIKit
import AVFoundation

class CameraPreview: UIView {

    private var label:UILabel?

    var previewLayer: AVCaptureVideoPreviewLayer?
    var session = AVCaptureSession()
    weak var delegate: QrCodeCameraDelegate?

    init(session: AVCaptureSession) {
        super.init(frame: .zero)
        self.session = session
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func onClick(){
        delegate?.onSimulateScanning()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = self.bounds
    }
}
