//
//  Classifier.swift
//  NutriGenie
//
//  Created by simge on 4.05.2024.
//

import Foundation
import TensorFlowLite
import UIKit
import VideoToolbox

class Classifier {
    private var interpreter: Interpreter
    private var labels: [String]?
    
    init?(modelPath: String, labelsPath: String) {
        do {
            guard let modelURL = Bundle.main.url(forResource: "model_unquant", withExtension: "tflite"),
                  let labelURL = Bundle.main.url(forResource: "labels", withExtension: "txt") else {
                print("Dosya yolları bulunamadı.")
                return nil
            }
            
            self.interpreter = try Interpreter(modelPath: modelURL.path)
            try self.interpreter.allocateTensors()
            
            let labelData = try String(contentsOf: labelURL, encoding: .utf8)
            self.labels = labelData.components(separatedBy: "\n")
            
            // Giriş tensörünün boyutlarını ve şeklini logla
            if let inputTensor = try? interpreter.input(at: 0) {
                //                                // Modelin beklediği boyutlara uygun şekilde yeniden boyutlandırma
                //                                let inputShape = Tensor.Shape([1, 224, 224, 3])
                //                                   try interpreter.resizeInput(at: 0, to: inputShape)
                //                                   print("Modelin giriş tensör boyutları: \(inputShape)")
                print("Modelin giriş tensör boyutları: \(inputTensor.shape.dimensions)")
            }
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    func bufferToTensor(pixelBuffer: CVPixelBuffer) -> Data? {
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        defer { CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly) }
        
        guard let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer) else {
            return nil
        }
        
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let bufferLength = bytesPerRow * height
        let data = Data(bytes: baseAddress, count: bufferLength)
        
        return data
    }
    
    // Görüntüyü modelin kabul ettiği formata yükle
    func classify(pixelBuffer: CVPixelBuffer) -> String? {
        // Giriş tensörünü almayı dene
        guard let _ = try? interpreter.input(at: 0),
              let inputData = bufferToTensor(pixelBuffer: pixelBuffer) else {
            print("Giriş tensoru veya dönüşüm verisi hazırlanamadı.")
            return nil
        }
        
        // Görüntü verisini yorumlayıcıya kopyala
        do {
            try interpreter.copy(inputData, toInputAt: 0)
            try interpreter.invoke()
            
            // Çıktı tensörünü al
            let outputTensor = try interpreter.output(at: 0)
            if let results = processResults(outputTensor) {
                return results
            } else {
                return "Sonuç işlenemedi."
            }
        } catch let error {
            print("Sınıflandırma hatası: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func processResults(_ outputTensor: Tensor) -> String? {
        // Tensör verilerini Float dizisine çevir
        let probabilities = outputTensor.data.withUnsafeBytes { (pointer: UnsafeRawBufferPointer) -> [Float] in
            let bufferPointer = pointer.bindMemory(to: Float.self)
            return Array(bufferPointer)
        }
        
        // En yüksek olasılığı ve etiketi bul
        guard let labels = self.labels, !probabilities.isEmpty else {
            return nil
        }
        let maxProbability = probabilities.max() ?? 0
        let maxIndex = probabilities.firstIndex(of: maxProbability) ?? 0
        let result = labels[maxIndex]
        return result
    }
}
