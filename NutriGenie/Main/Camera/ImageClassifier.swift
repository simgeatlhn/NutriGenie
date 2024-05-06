//
//  ImageClassifier.swift
//  NutriGenie
//
//  Created by simge on 6.05.2024.
//

import UIKit
import CoreML
import Vision

class ImageClassifier {
    private let model: MLModel
    
    init(model: MLModel) {
        self.model = model
    }
    
    func classify(pixelBuffer: CVPixelBuffer, completion: @escaping (String?) -> Void) {
        do {
            let model = try VNCoreMLModel(for: self.model)
            let request = VNCoreMLRequest(model: model) { request, error in
                guard let results = request.results as? [VNClassificationObservation],
                      let topResult = results.first else {
                    completion(nil)
                    return
                }
                completion(topResult.identifier)
            }
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try handler.perform([request])
        } catch {
            completion(nil)
        }
    }
}


