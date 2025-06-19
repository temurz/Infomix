//
//  QrCodeGeneratedView.swift
//  InfoMix
//
//  Created by Temur on 18/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QrCodeGeneratedView: View {
    let value: String
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        VStack {
            if let image = generateQrCode(from: value) {
                Image(uiImage: image)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.top, 4)
                    .padding(.horizontal)
            }
        }
    }
    
    private func generateQrCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        filter.message = data

        if let outputImage = filter.outputImage {
            // Scale it up (barcodes are small by default)
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            let scaledImage = outputImage.transformed(by: transform)

            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return nil
    }
}
