//
//  QRCodeView.swift
//  Wi-Fi Share
//
//  Created by Садырев Дмитрий on 08.09.2025.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let text: String
    var size: CGFloat = 200
    var foregroundColor: Color = .black
    var backgroundColor: Color = .white
    var errorCorrection: String = "M" // "L","M","Q","H"
    
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        if let uiImage = generateQRCode() {
            Image(uiImage: uiImage)
                .interpolation(.none) // не размывать
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        } else {
            Color.red
                .frame(width: size, height: size)
                .overlay(Text("Ошибка"))
        }
    }
    
    private func generateQRCode() -> UIImage? {
        guard let data = text.data(using: .utf8) else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue(errorCorrection, forKey: "inputCorrectionLevel")
        
        guard let outputImage = filter.outputImage else { return nil }
        
        // Цвета
        let colored = outputImage
            .applyingFilter("CIFalseColor", parameters: [
                "inputColor0": CIColor(color: UIColor(foregroundColor)),
                "inputColor1": CIColor(color: UIColor(backgroundColor))
            ])
        
        // Масштабирование
        let transform = CGAffineTransform(
            scaleX: size / colored.extent.width,
            y: size / colored.extent.height
        )
        let scaled = colored.transformed(by: transform)
        
        if let cgImage = context.createCGImage(scaled, from: scaled.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
}

#Preview {
    QRCodeView(text: "Test")
}
