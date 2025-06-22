//
//  ScannerView.swift
//  StockIt
//
//  Created by Ignacio Galliano on 07/03/2025.
//

import SwiftUI
import AVFoundation

struct BarcodeScannerContainerView: View {
    @StateObject var viewModel: BarcodeScannerViewModel

    var body: some View {
        VStack {
            BarcodeScannerView(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    viewModel.startScanning()
                }
        }
    }
}

struct BarcodeScannerView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: BarcodeScannerViewModel

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()

        guard let captureSession = viewModel.getCaptureSession() else {
            print("Capture session not available")
            return viewController
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = viewController.view.layer.bounds
        viewController.view.layer.addSublayer(previewLayer)

        viewModel.startScanning()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
