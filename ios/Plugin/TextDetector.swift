//
//  TextDetector.swift
//  Capacitor
//
//  Created by Vennela Kodali on 3/3/20.
//

import Foundation
import Vision
import Capacitor

@available(iOS 13.0, *)
public class TextDetector {
    var detectedText: [[String: Any]] = []
    let call: CAPPluginCall
    let image: UIImage

    public init(call: CAPPluginCall, image: UIImage) {
        self.call = call
        self.image = image
    }

    public func detectText() {
        // TODO: fail out if call is already used up
        guard let cgImage = image.cgImage else {
            print("Looks like uiImage is nil")
            return
        }

        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try imageRequestHandler.perform([self.textDetectionRequest])
                self.call.success(["detectedText": self.detectedText])
            } catch let error as NSError {
                print("Failed to perform image request: \(error)")
                self.call.reject(error.description)
            }
        }
    }

    lazy var textDetectionRequest: VNRecognizeTextRequest = {
        let textDetectRequest = VNRecognizeTextRequest(completionHandler: handleDetectedText)
        return textDetectRequest
    }()

    func handleDetectedText(request: VNRequest?, error: Error?) {
        if error != nil {
            call.reject("Text Detection Error \(String(describing: error))")
            return
        }
        DispatchQueue.main.async {
            guard let results = request?.results as? [VNRecognizedTextObservation] else {
                self.call.reject("error")
                return
            }
            
            self.detectedText = results.map {
                [
                    "topLeft": [Double($0.topLeft.x), Double($0.topLeft.y)],
                    "topRight": [Double($0.topRight.x), Double($0.topRight.y)],
                    "bottomLeft": [Double($0.bottomLeft.x), Double($0.bottomLeft.y)],
                    "bottomRight": [Double($0.bottomRight.x), Double($0.bottomRight.y)],
                    "text": $0.topCandidates(1).first?.string
                ]
            }
        }
    }
}