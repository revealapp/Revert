//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class DeepView: UIView {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    assert(type(of: self).subviewSpacing > 0, "Subview spacing must be a positive number")
  }

  override func layoutSubviews() {
    self.updateSubViews()

    super.layoutSubviews()
  }

  override static var requiresConstraintBasedLayout: Bool {
    return true
  }

  // MARK: Private

  private static let subviewSpacing: CGFloat = 5

  private static func colorForIndex(_ index: Int) -> UIColor {
    if index % 5 == 0 {
      return [.revertDarkBlue, .revertOrange, .revertPink][(index / 5) % 3]
    }
    return UIColor.white
  }

  private static func constraintsForSubview(_ subview: UIView, constant: CGFloat, priority: UILayoutPriority) -> [NSLayoutConstraint] {
    let bindingViews = ["subview": subview]
    let horizontalConstraints = NSLayoutConstraint.constraints(
      withVisualFormat: "H:|-\(constant)@\(priority)-[subview]-\(constant)@\(priority)-|",
      options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil,
      views: bindingViews)
    let verticalConstraints = NSLayoutConstraint.constraints(
      withVisualFormat: "V:|-\(constant)@\(priority)-[subview]-\(constant)@\(priority)-|",
      options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil,
      views: bindingViews)
    return horizontalConstraints + verticalConstraints
  }

  private static func updateSubviewsRecursively(_ view: UIView, length: CGFloat, constant: CGFloat, depth: Int = 0) {
    if length > 2 * constant {
      // Enough space for subviews
      if view.subviews.count == 0 {
        let subview = UIView()
        subview.backgroundColor = self.colorForIndex(Int(depth)).withAlphaComponent(0.5)
        subview.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(subview)

        // Prevents constraints from being invalid on rotation. Subviews added/removed on `layoutSubviews`
        let priority = UILayoutPriority(rawValue: Float(1000 - CGFloat(depth)))
        let constraints = self.constraintsForSubview(subview, constant: constant, priority: priority)
        view.addConstraints(constraints)
      }
      self.updateSubviewsRecursively(view.subviews.first!, length: length - 2 * constant, constant: constant, depth: depth + 1)
    } else if let subview = view.subviews.first {
      subview.removeFromSuperview()
    }
  }

  private func updateSubViews() {
    let length = min(self.bounds.size.width, self.bounds.size.height)
    type(of: self).updateSubviewsRecursively(self, length: length, constant: type(of: self).subviewSpacing)
  }
}
