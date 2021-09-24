//
//  QRCodeReaderViewController.swift
//  StructuredQRCodeReader
//
//  Created by kazuhiro nanko on 2021/09/24.
//

import UIKit
import Foundation

public class QRCodeReaderViewController: UIViewController {
    
    var viewModel : ScannerViewModel = .init()

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.isShowing = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.isShowing = false
    }
    
    func configure() {
        view.backgroundColor = .white
        
        let v = QrCodeScannerView(frame: view.bounds)
            .found(r: viewModel.onFoundQrCode)
            .interval(delay: viewModel.scanInterval)
        view.addSubview(v)
    }
}
