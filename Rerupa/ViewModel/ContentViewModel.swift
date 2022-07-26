//
//  ContentViewModel.swift
//  Rerupa
//
//  Created by Balqis on 19/07/22.
//

import Vision
import SwiftUI
import Foundation
import PencilKit

class ContentViewModel: ObservableObject {
    
    @Published var canvas = PKCanvasView()
    @Published var toolPicker = false
    
    @Published var uiImage: UIImage?
    
    @Published var image: CGImage?
    @Published var contours: [Contour] = []
    @Published var calculating = false
    
    func startContour() {
        let cgImage = uiImage?.cgImage
        self.image = cgImage
        
        updateContours()
    }
    
    func updateContours() {
        calculating = true
        Task {
            let contours = await asyncUpdateContours()
            DispatchQueue.main.async {
                self.contours = contours
                self.calculating = false
            }
        }
    }
    
    func asyncUpdateContours() async -> [Contour] {
        var contours: [Contour] = []
        
        let pivotStride = stride(
            from: UserDefaults.standard.minPivot,
            to: UserDefaults.standard.maxPivot,
            by: 0.1)
        let adjustStride = stride(
            from: UserDefaults.standard.minAdjust,
            to: UserDefaults.standard.maxAdjust,
            by: 0.2)
        
        let detector = ContourDetector.shared
        
        detector.set(epsilon: UserDefaults.standard.epsilon)
        
        for pivot in pivotStride {
            for adjustment in adjustStride {
                detector.set(contrastPivot: pivot)
                detector.set(contrastAdjustment: adjustment)
                
                let newContours = (try? detector.process(image: self.image)) ?? []
                
                contours.append(contentsOf: newContours)
            }
        }
        
        if contours.count < 9000 {
            let iouThreshold = UserDefaults.standard.iouThresh
            
            var pos = 0
            while pos < contours.count {
                let contour = contours[pos]
                contours = contours[0...pos] + contours[(pos + 1)...].filter {
                    contour.intersectionOverUnion(with: $0) < iouThreshold
                }
                pos += 1
            }
        }
        
        return contours
    }
}
