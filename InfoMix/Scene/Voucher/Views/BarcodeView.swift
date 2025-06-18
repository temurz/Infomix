//
//  BarcodeView.swift
//  InfoMix
//
//  Created by Temur on 18/06/2025.
//  Copyright © 2025 InfoMix. All rights reserved.
//


import SwiftUI
import CoreImage.CIFilterBuiltins
import Localize_Swift

struct BarcodeView: View {
    let value: String
    private let context = CIContext()
    private let filter = CIFilter.code128BarcodeGenerator()
    var cancelAction: (() -> Void)?

    var body: some View {
        if let image = generateBarcode(from: value) {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        cancelAction?()
                    } label: {
                        Image(systemName: "x.circle")
                            .centerCropped()
                            .tint(.black)
                            .frame(width: 24, height: 24)
                            .padding()
                    }
                }
                Text("To receive the voucher, show this code to the payment point manager.".localized())
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                Image(uiImage: image)
                    .interpolation(.none) // for sharp edges
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.top, 4)
                    .padding(.horizontal)
                Text(value)
                    .padding(.bottom)
            }
            .background(.white)
            .cornerRadius(radius: 12, corners: .allCorners)
           
        } else {
            Text("Failed to generate barcode")
        }
    }

    private func generateBarcode(from string: String) -> UIImage? {
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
