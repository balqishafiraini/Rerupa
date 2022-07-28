//
//  ImageView.swift
//  Rerupa
//
//  Created by Balqis on 19/07/22.
//

import SwiftUI

struct ImageView: View {
  let image: CGImage?

  private let label = Text("Image to draw")

  var body: some View {
    if let image = image {
        Image(image, scale: 1.0, orientation: .up, label: label)
        .resizable()
        .scaledToFit()
    } else {
      EmptyView()
    }
  }
}

struct ImageView_Previews: PreviewProvider {
  static var previews: some View {
    ImageView(image: nil)
  }
}
