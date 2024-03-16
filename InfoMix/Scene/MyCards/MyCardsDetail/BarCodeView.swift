//
//  BarCodeView.swift
//  InfoMix
//
//  Created by Temur on 27/01/22.
//  Copyright © 2022 InfoMix. All rights reserved.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct BarCodeView : View{
    
    let context = CIContext()
    let filter = CIFilter.barcodeGenerator()
    var url: String
    
    var body: some View{
        Image(uiImage: generateBarCode(url))
    }
    
    func generateBarCode(_ url: String) -> UIImage{
        let data = url.utf8
        filter.setValue(data, forKey: "inputMessage")
        
        if let barCodeImage = filter.outputImage{
            if let barCodeCGImage = context.createCGImage(barCodeImage, from: barCodeImage.extent){
                return UIImage(cgImage: barCodeCGImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}
