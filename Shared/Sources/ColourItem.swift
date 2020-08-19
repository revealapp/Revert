// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import UIKit

struct ColourItem {
  let name: String
  let color: UIColor

  init(name: String, color: UIColor) {
    self.name = name
    self.color = color
  }
}

extension ColourItem {
  private var rgbaText: String {
    let ciColor = CIColor(cgColor: color.cgColor)
    return "R:\((ciColor.red * 255).withoutDecimal) " +
      "G:\((ciColor.green * 255).withoutDecimal) " +
      "B:\((ciColor.blue * 255).withoutDecimal) " +
      "\(isTransparent ? "(\((ciColor.alpha * 100).withoutDecimal)%)" : "")"
  }

  private var isTransparent: Bool {
    CIColor(cgColor: color.cgColor).alpha < 1
  }

  @available(iOS 13.0, *)
  private var circleSymbol: UIImage {
    let config = UIImage.SymbolConfiguration(
      pointSize: UIFont.smallSystemFontSize,
      weight: .regular, scale: .default
    )

    guard let image = UIImage(
      systemName: isTransparent ? "circle.lefthalf.fill" : "circle.fill",
      withConfiguration: config
      ) else {
        fatalError("Cannot init SFSymbol")
    }

    return image.withTintColor(.systemGray)
  }

  var detailText: NSAttributedString {
    let imageAttachment = NSTextAttachment()
    if #available(iOS 13.0, *) {
      imageAttachment.image = circleSymbol
    }

    let detailText = NSMutableAttributedString(string: "")
    detailText.append(NSAttributedString(attachment: imageAttachment))
    detailText.append(NSAttributedString(string: " "))
    detailText.append(NSAttributedString(string: rgbaText))

    return detailText
  }
}

private extension CGFloat {
  var withoutDecimal: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 0
    return "\(formatter.string(from: NSNumber(value: Float(self))) ?? "")"
  }
}
