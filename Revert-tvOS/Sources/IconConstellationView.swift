//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.
//

import UIKit

class IconConstellationView: UIView {

  var animatedIcons: [UIImage] = [] {
    didSet {
      self.reloadIconViews()
    }
  }

  var iconSize = 100.0 as CGFloat {
    didSet {
      self.setNeedsLayout()
    }
  }

  var iconSpacing = 26.0 as CGFloat {
    didSet {
      self.setNeedsLayout()
    }
  }

  var animating = false {
    didSet {
      if self.animating != oldValue && self.window != nil {
        if self.animating {
          self.animateIconViews()
        } else {
          self.stopAnimatingIconViews()
        }
      }
    }
  }

  override func didMoveToWindow() {
    super.didMoveToWindow()
    self.animateIconViewsIfNecessary()
  }

  override class var requiresConstraintBasedLayout: Bool {
    return false
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.layoutIconViews()
  }

  // MARK: Icon views

  private var iconViews: [UIImageView] = []

  private func reloadIconViews() {
    self.iconViews.forEach { $0.removeFromSuperview() }

    self.iconViews = self.animatedIcons.map { image in
      let imageView = UIImageView(image: image)
      imageView.contentMode = .center

      return imageView
    }

    self.iconViews.forEach(self.addSubview)

    self.setNeedsLayout()
    self.animateIconViewsIfNecessary()
  }

  private func layoutIconViews() {
    let bounds = self.bounds
    let iconsPerLine = Int(floor((bounds.width + self.iconSpacing) / (self.iconSize + self.iconSpacing)))
    let lineLayout = type(of: self).lineLayout(forWidth: bounds.width, iconSize: self.iconSize, iconsPerLine: iconsPerLine, contentsScale: self.window?.screen.scale ?? 1.0)

    for (index, iconView) in self.iconViews.enumerated() {
      let columnRect = lineLayout[index % iconsPerLine]
      let lineOffset = CGFloat(index / iconsPerLine) * (self.iconSize + self.iconSpacing)
      iconView.frame = columnRect.offsetBy(dx: 0.0, dy: lineOffset)
    }
  }

  private static func lineLayout(forWidth width: CGFloat, iconSize: CGFloat, iconsPerLine: Int, contentsScale: CGFloat) -> [CGRect] {
    var rects = [CGRect]()
    var remainingLineSpacing = width - iconSize * CGFloat(iconsPerLine)
    var currentPosition = 0.0 as CGFloat
    for remainingSpaces in (0..<iconsPerLine).reversed() {
      rects.append(CGRect(x: currentPosition, y: 0.0, width: iconSize, height: iconSize))
      currentPosition += iconSize

      if remainingSpaces > 0 {
        let spacing = floor((remainingLineSpacing / CGFloat(remainingSpaces)) * contentsScale) / contentsScale
        currentPosition += spacing
        remainingLineSpacing -= spacing
      }
    }

    return rects
  }

  // MARK: Animation

  private func animateIconViewsIfNecessary() {
    if self.animating && self.window != nil {
      self.animateIconViews()
    }
  }

  private func animateIconViews() {
    self.iconViews.forEach { $0.animateTwinkleWithRandomParameters() }
  }

  private func stopAnimatingIconViews() {
    self.iconViews.forEach { $0.stopTwinkleAnimation() }
  }

}

// MARK: - Animation extension

private extension UIView {

  private struct Constants {
    static let animationKey = "twinkle"
  }

  func animateTwinkle(withDuration duration: TimeInterval, initialPhase: Double) {
    let animation = CABasicAnimation(keyPath: "opacity")
    animation.duration = duration
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    animation.fromValue = 1.0 as NSNumber
    animation.toValue = 0.3 as NSNumber
    animation.autoreverses = true
    animation.repeatCount = FLT_MAX
    animation.timeOffset = duration * initialPhase * 2.0

    self.layer.add(animation, forKey: Constants.animationKey)
  }

  func animateTwinkleWithRandomParameters() {
    self.animateTwinkle(withDuration: Double.random(between: 1.0, and: 4.0),
                        initialPhase: Double.random(between: 0.0, and: 1.0))
  }

  func stopTwinkleAnimation() {
    self.layer.removeAnimation(forKey: Constants.animationKey)
  }

}
