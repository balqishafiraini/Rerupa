//
//  VNContour.swift
//  Rerupa
//
//  Created by Balqis on 19/07/22.
//

import Vision

extension VNContour {
  var boundingBox: CGRect {
    var minX: Float = 1.0
    var minY: Float = 1.0
    var maxX: Float = 0.0
    var maxY: Float = 0.0

    for point in normalizedPoints {
      if point.x < minX {
        minX = point.x
      } else if point.x > maxX {
        maxX = point.x
      }

      if point.y < minY {
        minY = point.y
      } else if point.y > maxY {
        maxY = point.y
      }
    }

    return CGRect(
      x: Double(minX),
      y: Double(minY),
      width: Double(maxX - minX),
      height: Double(maxY - minY))
  }
}
