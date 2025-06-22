//
//  ScannerViewModel.swift
//  StockIt
//
//  Created by Ignacio Galliano on 07/03/2025.
//

import SwiftUI
import AVFoundation

class BarcodeScannerViewModel: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    private var captureSession: AVCaptureSession?
    private let coordinator: StockItCoordinator?
    private let productsUseCases: ProductsUseCases

    init(productsUseCases: ProductsUseCases = DefaultProductsUseCases(),
         coordinator: StockItCoordinator) {
        self.coordinator = coordinator
        self.productsUseCases = productsUseCases
        super.init()
        setupSession()
    }

    private func setupSession() {
        let session = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }

        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if session.canAddInput(videoInput) {
                session.addInput(videoInput)
            }
        } catch {
            print("Error setting up camera input: \(error.localizedDescription)")
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .qr]
        }

        self.captureSession = session
    }

    @MainActor
    func startScanning() {
        captureSession?.startRunning()
    }

    func stopScanning() {
        captureSession?.stopRunning()
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
            let code = metadataObject.stringValue {
            openNextScreen(upc: code)
            stopScanning()
        }
    }

    func openNextScreen(upc: String) {
        Task {
            if let product = try await productsUseCases.getProduct(upc: upc) {
                coordinator?.open(page: .transaction, isRoot: false, parameters: ["Product" : product])
            } else {
                coordinator?.open(page: .productEdition, isRoot: false, parameters: ["BarCode" : upc])
            }
        }
    }

    func getCaptureSession() -> AVCaptureSession? {
        return captureSession
    }
}

