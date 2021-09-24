//
//  QRCodeReaderSetting.swift
//  StructuredQRCodeReader
//
//  Created by kazuhiro nanko on 2021/09/24.
//

import Foundation

public class QRCodeReaderSetting {
    public var scanInterval: Double = 1.0
    public var lastTime = Date(timeIntervalSince1970: 0)
}
