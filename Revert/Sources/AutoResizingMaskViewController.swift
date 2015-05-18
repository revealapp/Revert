//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AutoResizingMaskViewController: RevertViewController {
  @IBOutlet weak var outterView: UIView!
  
  private var viewsWereSetup = false
  
  private static let padding: CGFloat = 20
  private static let cornerRadius: CGFloat = 2
  private static let borderWidth: CGFloat = 1
  private static let borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor
  private static let defaultViewSideLength: CGFloat = 50
  private static let leftRightWidth: CGFloat = 80
  
  private func addSubViewsIfNeeded() {
    // Only perform this action once
    if self.viewsWereSetup {
      return
    }
    self.viewsWereSetup = true
    
    // Back: Flexible Height / Width View
    let origin = CGPoint(x: self.dynamicType.padding, y: self.dynamicType.padding)
    let flexibleWidthHeightSize = CGSize(
      width: self.outterView.bounds.width - (2 * self.dynamicType.padding),
      height: self.outterView.bounds.height - (2 * self.dynamicType.padding)
    )
    let flexibleWidthHeightView = UIView(frame: CGRect(origin: origin, size: flexibleWidthHeightSize))
    
    flexibleWidthHeightView.backgroundColor = UIColor.clearColor()
    flexibleWidthHeightView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
    flexibleWidthHeightView.layer.cornerRadius = self.dynamicType.cornerRadius
    flexibleWidthHeightView.layer.borderWidth = self.dynamicType.borderWidth
    flexibleWidthHeightView.layer.borderColor = UIColor.whiteColor().CGColor
    self.outterView.addSubview(flexibleWidthHeightView)
    
    // Top: Flexible Width View
    let flexibleWidthSize = CGSize(
      width: flexibleWidthHeightSize.width - (2 * self.dynamicType.padding),
      height: self.dynamicType.defaultViewSideLength
    )
    let flexibleWidthView = UIView(frame: CGRect(origin: origin, size: flexibleWidthSize))
    
    flexibleWidthView.backgroundColor = UIColor.revertDarkblueColor()
    flexibleWidthView.autoresizingMask = .FlexibleWidth
    flexibleWidthView.layer.cornerRadius = self.dynamicType.cornerRadius
    flexibleWidthView.layer.borderWidth = self.dynamicType.borderWidth
    flexibleWidthView.layer.borderColor = self.dynamicType.borderColor
    
    flexibleWidthHeightView.addSubview(flexibleWidthView)
    
    // Middle: Flexible Height / Left / Right View
    let flexibleHeightLeftRightSize = CGSize(
      width: self.dynamicType.defaultViewSideLength,
      height: flexibleWidthHeightSize.height - flexibleWidthView.frame.maxY - (2 * self.dynamicType.padding)
    )
    
    let flexibleHeightLeftRightOrigin = CGPoint(
      x: (flexibleWidthHeightView.bounds.width - flexibleHeightLeftRightSize.width) / 2,
      y: flexibleWidthView.frame.maxY + self.dynamicType.padding
    )
    let flexibleHeightLeftRightView = UIView(frame: CGRect(
      origin: flexibleHeightLeftRightOrigin,
      size: flexibleHeightLeftRightSize)
    )
    
    flexibleHeightLeftRightView.backgroundColor = UIColor.revertOrangeColor()
    flexibleHeightLeftRightView.layer.cornerRadius = self.dynamicType.cornerRadius
    flexibleHeightLeftRightView.layer.borderWidth = self.dynamicType.borderWidth
    flexibleHeightLeftRightView.layer.borderColor = self.dynamicType.borderColor
    flexibleHeightLeftRightView.autoresizingMask = .FlexibleHeight | .FlexibleLeftMargin | .FlexibleRightMargin
    flexibleWidthHeightView.addSubview(flexibleHeightLeftRightView)
    
    // Left: Flexible Top / Bottom View
    let flexibleTopBottomSize = CGSize(
      width: self.dynamicType.leftRightWidth,
      height: self.dynamicType.defaultViewSideLength
    )
    let leftFlexibleTopBottomOrigin = CGPoint(
      x: self.dynamicType.padding,
      y: flexibleHeightLeftRightView.frame.midY - flexibleTopBottomSize.height / 2
    )
    let leftFlexibleTopBottomView = UIView(frame: CGRect(origin: leftFlexibleTopBottomOrigin, size: flexibleTopBottomSize))
    
    leftFlexibleTopBottomView.backgroundColor = UIColor.awesgreenColor()
    leftFlexibleTopBottomView.layer.borderWidth = self.dynamicType.borderWidth
    leftFlexibleTopBottomView.layer.cornerRadius = self.dynamicType.cornerRadius
    leftFlexibleTopBottomView.layer.borderColor = self.dynamicType.borderColor
    leftFlexibleTopBottomView.autoresizingMask = .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleRightMargin
    flexibleWidthHeightView.addSubview(leftFlexibleTopBottomView)
    
    // Right: Flexible Top / Bottom View
    let rightFlexibleTopBottomOrigin = CGPoint(x:
      flexibleWidthHeightView.bounds.width - self.dynamicType.padding - self.dynamicType.leftRightWidth,
      y: flexibleHeightLeftRightView.frame.midY - flexibleTopBottomSize.height / 2
    )
    let rightFlexibleTopBottomView = UIView(frame: CGRect(origin: rightFlexibleTopBottomOrigin, size: flexibleTopBottomSize))
    
    rightFlexibleTopBottomView.backgroundColor = UIColor.revertPinkColor()
    rightFlexibleTopBottomView.layer.borderWidth = self.dynamicType.borderWidth
    rightFlexibleTopBottomView.layer.borderColor = self.dynamicType.borderColor
    rightFlexibleTopBottomView.layer.cornerRadius = self.dynamicType.cornerRadius
    rightFlexibleTopBottomView.autoresizingMask = .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleLeftMargin
    flexibleWidthHeightView.addSubview(rightFlexibleTopBottomView)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.addSubViewsIfNeeded()
  }
}

