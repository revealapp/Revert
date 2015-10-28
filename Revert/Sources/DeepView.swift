//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class DeepView: UIView {
  private let subviewSpacing: CGFloat = 5

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    assert(self.subviewSpacing > 0, "Subview spacing must be a positive number")
  }
  
  private static func colorForIndex(index: Int) -> UIColor {
    if index % 5 == 0 {
      return [UIColor.revertDarkblueColor(), UIColor.revertOrangeColor(), UIColor.revertPinkColor()][(index / 5) % 3]
    }
    return UIColor.whiteColor()
  }
  
  private static func constraintsForSubview(subview: UIView, constant: CGFloat, priority: UILayoutPriority) -> [NSLayoutConstraint] {
    let bindingViews = ["subview": subview]
    let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
      "H:|-\(constant)@\(priority)-[subview]-\(constant)@\(priority)-|",
      options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil,
      views: bindingViews)
    let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
      "V:|-\(constant)@\(priority)-[subview]-\(constant)@\(priority)-|",
      options: NSLayoutFormatOptions(rawValue: 0),
      metrics: nil,
      views: bindingViews)
    return horizontalConstraints + verticalConstraints
  }
  
  private static func updateSubviewsRecursively(view: UIView, length: CGFloat, constant: CGFloat, depth: Int = 0) {
    if length > 2 * constant {
      // Enough space for subviews
      if view.subviews.count == 0 {
        let subview = UIView()
        subview.backgroundColor = self.colorForIndex(Int(depth)).colorWithAlphaComponent(0.5)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(subview)
        
        // Prevents constraints from being invalid on rotation. Subviews added/removed on `layoutSubviews`
        let priority = UILayoutPriority(1000 - CGFloat(depth))
        let constraints = self.constraintsForSubview(subview, constant: constant, priority: priority)
        view.addConstraints(constraints)
      }
      self.updateSubviewsRecursively(view.subviews.first!, length: length - 2 * constant, constant: constant, depth: depth + 1)
    } else if let subview = view.subviews.first {
      subview.removeFromSuperview()
    }
  }
  
  override func layoutSubviews() {
    self.updateSubViews()

    super.layoutSubviews()
  }
  
  override static func requiresConstraintBasedLayout() -> Bool {
    return true
  }

  private func updateSubViews() {
    let length = min(self.bounds.size.width, self.bounds.size.height)
    self.dynamicType.updateSubviewsRecursively(self, length: length, constant: self.subviewSpacing)
  }
}
