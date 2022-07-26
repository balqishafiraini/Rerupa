//
//  DrawingLine.swift
//  Rerupa
//
//  Created by Balqis on 21/07/22.
//

import Foundation
import SwiftUI

struct Line: Identifiable {
    
    var points: [CGPoint]
    var color: Color
    var lineWidth: CGFloat

    let id = UUID()
}
