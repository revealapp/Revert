//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AutoResizingMaskViewController: RevertViewController {
  @IBOutlet private weak var outterView: UIView!
  
  private var wereViewsSetup = false
  
  private let padding: CGFloat = 20
  private let cornerRadius: CGFloat = 2
  private let borderWidth: CGFloat = 1
  private let borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor
  private let defaultViewSideLength: CGFloat = 50
  private let leftRightWidth: CGFloat = 80
  
  private func addSubViewsIfNeeded() {
    // Only perform this action once
    if self.wereViewsSetup {
      return
    }
    self.wereViewsSetup = true
    
    // Back: Flexible Height / Width View
    let origin = CGPoint(x: self.padding, y: self.padding)
    let flexibleWidthHeightSize = CGSize(
      width: self.outterView.bounds.width - (2 * self.padding),
      height: self.outterView.bounds.height - (2 * self.padding)
    )
    let flexibleWidthHeightView = UIView(frame: CGRect(origin: origin, size: flexibleWidthHeightSize))
    
    flexibleWidthHeightView.backgroundColor = UIColor.clearColor()
    flexibleWidthHeightView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    flexibleWidthHeightView.layer.cornerRadius = self.cornerRadius
    flexibleWidthHeightView.layer.borderWidth = self.borderWidth
    flexibleWidthHeightView.layer.borderColor = UIColor.whiteColor().CGColor
    self.outterView.addSubview(flexibleWidthHeightView)
    
    // Top: Flexible Width View
    let flexibleWidthSize = CGSize(
      width: flexibleWidthHeightSize.width - (2 * self.padding),
      height: self.defaultViewSideLength
    )
    let flexibleWidthView = UIView(frame: CGRect(origin: origin, size: flexibleWidthSize))
    
    flexibleWidthView.backgroundColor = UIColor.revertDarkblueColor()
    flexibleWidthView.autoresizingMask = .FlexibleWidth
    flexibleWidthView.layer.cornerRadius = self.cornerRadius
    flexibleWidthView.layer.borderWidth = self.borderWidth
    flexibleWidthView.layer.borderColor = self.borderColor
    
    flexibleWidthHeightView.addSubview(flexibleWidthView)
    
    // Middle: Flexible Height / Left / Right View
    let flexibleHeightLeftRightSize = CGSize(
      width: self.defaultViewSideLength,
      height: flexibleWidthHeightSize.height - flexibleWidthView.frame.maxY - (2 * self.padding)
    )
    
    let flexibleHeightLeftRightOrigin = CGPoint(
      x: (flexibleWidthHeightView.bounds.width - flexibleHeightLeftRightSize.width) / 2,
      y: flexibleWidthView.frame.maxY + self.padding
    )
    let flexibleHeightLeftRightView = UIView(frame: CGRect(
      origin: flexibleHeightLeftRightOrigin,
      size: flexibleHeightLeftRightSize)
    )
    
    flexibleHeightLeftRightView.backgroundColor = UIColor.revertOrangeColor()
    flexibleHeightLeftRightView.layer.cornerRadius = self.cornerRadius
    flexibleHeightLeftRightView.layer.borderWidth = self.borderWidth
    flexibleHeightLeftRightView.layer.borderColor = self.borderColor
    flexibleHeightLeftRightView.autoresizingMask = [.FlexibleHeight, .FlexibleLeftMargin, .FlexibleRightMargin]
    flexibleWidthHeightView.addSubview(flexibleHeightLeftRightView)
    
    // Left: Flexible Top / Bottom View
    let flexibleTopBottomSize = CGSize(
      width: self.leftRightWidth,
      height: self.defaultViewSideLength
    )
    let leftFlexibleTopBottomOrigin = CGPoint(
      x: self.padding,
      y: flexibleHeightLeftRightView.frame.midY - flexibleTopBottomSize.height / 2
    )
    let leftFlexibleTopBottomView = UIView(frame: CGRect(origin: leftFlexibleTopBottomOrigin, size: flexibleTopBottomSize))
    
    leftFlexibleTopBottomView.backgroundColor = UIColor.awesgreenColor()
    leftFlexibleTopBottomView.layer.borderWidth = self.borderWidth
    leftFlexibleTopBottomView.layer.cornerRadius = self.cornerRadius
    leftFlexibleTopBottomView.layer.borderColor = self.borderColor
    leftFlexibleTopBottomView.autoresizingMask = [.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleRightMargin]
    flexibleWidthHeightView.addSubview(leftFlexibleTopBottomView)
    
    // Right: Flexible Top / Bottom View
    let rightFlexibleTopBottomOrigin = CGPoint(x:
      flexibleWidthHeightView.bounds.width - self.padding - self.leftRightWidth,
      y: flexibleHeightLeftRightView.frame.midY - flexibleTopBottomSize.height / 2
    )
    let rightFlexibleTopBottomView = UIView(frame: CGRect(origin: rightFlexibleTopBottomOrigin, size: flexibleTopBottomSize))
    
    rightFlexibleTopBottomView.backgroundColor = UIColor.revertPinkColor()
    rightFlexibleTopBottomView.layer.borderWidth = self.borderWidth
    rightFlexibleTopBottomView.layer.borderColor = self.borderColor
    rightFlexibleTopBottomView.layer.cornerRadius = self.cornerRadius
    rightFlexibleTopBottomView.autoresizingMask = [.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleLeftMargin]
    flexibleWidthHeightView.addSubview(rightFlexibleTopBottomView)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.addSubViewsIfNeeded()
  }
}

