// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import Foundation

final class DynamicColourCell: BasicCell {

  func setupCell(with colourItem: ColourItem) {
    if #available(iOS 10.0, *) {
      let imageSize = CGSize(width: 50, height: 50)
      self.imageView?.image = UIGraphicsImageRenderer(size: imageSize)
        .image { rendererContext in
          colourItem.color.setFill()
          rendererContext.fill(CGRect(origin: .zero, size: imageSize))
      }
    }

    self.imageView?.clipsToBounds = true
    self.imageView?.layer.cornerRadius = 10

    self.detailTextLabel?.attributedText = colourItem.detailText
    self.detailTextLabel?.textColor = .systemGray

    self.textLabel?.text = colourItem.name
  }

}
