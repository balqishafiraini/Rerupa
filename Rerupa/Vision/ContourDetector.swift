//
//  ContourDetector.swift
//  Rerupa
//
//  Created by Balqis on 19/07/22.
//

import Vision

class ContourDetector {
  static let shared = ContourDetector()

  private var epsilon: Float = 0.001
  private lazy var request: VNDetectContoursRequest = {
    let req = VNDetectContoursRequest()
    return req
  }()

  private init() {}

  private func postProcess(request: VNRequest) -> [Contour] {
    guard let results = request.results as? [VNContoursObservation] else {
      return []
    }

    let vnContours = results.flatMap { contour in
      (0..<contour.contourCount).compactMap { try? contour.contour(at: $0) }
    }
    let simplifiedContours = vnContours.compactMap {
      try? $0.polygonApproximation(epsilon: self.epsilon)
    }

    return simplifiedContours.map { Contour(vnContour: $0) }
  }

  private func perform(_ request: VNRequest, on image: CGImage) throws -> VNRequest {
    let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
    try requestHandler.perform([request])
    return request
  }

  func process(image: CGImage?) throws -> [Contour] {
    guard let image = image else {
      return []
    }

    let contourRequest = try perform(request, on: image)

    return postProcess(request: contourRequest)
  }

  func set(epsilon: CGFloat) {
    self.epsilon = Float(epsilon)
  }

  func set(contrastPivot: CGFloat?) {
    request.contrastPivot = contrastPivot.map { NSNumber(value: $0) }
  }

  func set(contrastAdjustment: CGFloat) {
    request.contrastAdjustment = Float(contrastAdjustment)
  }
}
