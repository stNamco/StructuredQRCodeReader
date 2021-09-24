//
//  CameraPreview.swift
//  StructuredQRCodeReader
//
//  Created by kazuhiro nanko on 2021/09/23.
//

import UIKit
import AVFoundation

class CameraPreview: UIView {

    var previewLayer: AVCaptureVideoPreviewLayer?
    var session = AVCaptureSession()
    weak var delegate: QrCodeCameraDelegate?

    init(session: AVCaptureSession, frame: CGRect) {
        super.init(frame: frame)
        self.session = session
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = self.bounds
    }
}
