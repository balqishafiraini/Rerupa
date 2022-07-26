//
//  DrawingShape.swift
//  Rerupa
//
//  Created by Balqis on 21/07/22.
//

import SwiftUI

struct DrawingShape: Shape {
    let points: [CGPoint]
    let engine = DrawingEngine()
    func path(in rect: CGRect) -> Path {
        engine.createPath(for: points)
    }
}
