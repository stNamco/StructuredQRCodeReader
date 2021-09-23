//
//  ContentView.swift
//  StructuredQRCodeReader
//
//  Created by kazuhiro nanko on 2021/09/23.
//

import SwiftUI

public struct ContentView: View {
    @ObservedObject var viewModel = ScannerViewModel()
    
    public init() {}

    public var body: some View {

        VStack {
            Text("QR Code Reader")
                .padding()

            // 読み取ったQRコード表示位置
            Text("URL = [ " + viewModel.lastQrCode + " ]")

            Button(action: {
                viewModel.isShowing = true
            }){
                Text("カメラ起動")
                Image(systemName: "camera")
            }
            .fullScreenCover(isPresented: $viewModel.isShowing) {
                ScannerView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
