//
//  QRCodeParser.swift
//  StructuredQRCodeReader
//
//  Created by kazuhiro nanko on 2021/09/24.
//

import Foundation
import AVFoundation

class QRCodeParser {
    // TODO:
    static func parse(metadataObjects: [AVMetadataObject]) -> String? {
        guard let metadataObject = metadataObjects.first else {
            return nil
        }
        guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return nil }
        guard let stringValue = readableObject.stringValue else { return nil }
        
        return stringValue
    }
}
