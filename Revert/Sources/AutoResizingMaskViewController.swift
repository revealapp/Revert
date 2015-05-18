//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AutoResizingMaskViewController: RevertViewController {

  @IBOutlet weak var outterView: UIView!
  
  private var viewsWereSetup = false
  
  private func addSubViewsIfNeeded() {
    // Only perform this action once
    if self.viewsWereSetup {
      return
    }
    self.viewsWereSetup = true
    
    let padding:CGFloat = 20
    let cornerRadius:CGFloat = 2
    let borderWidth:CGFloat = 1
    let borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.15).CGColor
    let defaultViewSideLength: CGFloat = 50
    let leftRightWidth: CGFloat = 80
    
    // Back: Flexible Height / Width View
    let origin = CGPoint(x: padding, y: padding)
    let flexibleWidthHeightSize = CGSize(width: self.outterView.bounds.width - (2 * padding), height: self.outterView.bounds.height - (2 * padding))
    let flexibleWidthHeightView = UIView(frame: CGRect(origin: origin, size: flexibleWidthHeightSize))
    
    flexibleWidthHeightView.backgroundColor = UIColor.clearColor()
    flexibleWidthHeightView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
    flexibleWidthHeightView.layer.cornerRadius = cornerRadius
    flexibleWidthHeightView.layer.borderWidth = borderWidth
    flexibleWidthHeightView.layer.borderColor = UIColor.whiteColor().CGColor
    self.outterView.addSubview(flexibleWidthHeightView)
    
    // Top: Flexible Width View
    let flexibleWidthSize = CGSize(width: flexibleWidthHeightSize.width - (2 * padding), height: defaultViewSideLength)
    let flexibleWidthView = UIView(frame: CGRect(origin: origin, size: flexibleWidthSize))
    
    flexibleWidthView.backgroundColor = UIColor.revertDarkblueColor()
    flexibleWidthView.autoresizingMask = .FlexibleWidth
    flexibleWidthView.layer.cornerRadius = cornerRadius
    flexibleWidthView.layer.borderWidth = borderWidth
    flexibleWidthView.layer.borderColor = borderColor
    
    flexibleWidthHeightView.addSubview(flexibleWidthView)
    
    // Middle: Flexible Height / Left / Right View
    let flexibleHeightLeftRightSize = CGSize(width: defaultViewSideLength, height: flexibleWidthHeightSize.height - flexibleWidthView.frame.maxY - (2 * padding))
    let flexibleHeightLeftRightOrigin = CGPoint(x: (flexibleWidthHeightView.bounds.width - flexibleHeightLeftRightSize.width) / 2, y: flexibleWidthView.frame.maxY + padding)
    let flexibleHeightLeftRightView = UIView(frame: CGRect(origin: flexibleHeightLeftRightOrigin, size: flexibleHeightLeftRightSize))
    
    flexibleHeightLeftRightView.backgroundColor = UIColor.revertOrangeColor()
    flexibleHeightLeftRightView.layer.cornerRadius = cornerRadius
    flexibleHeightLeftRightView.layer.borderWidth = borderWidth
    flexibleHeightLeftRightView.layer.borderColor = borderColor
    flexibleHeightLeftRightView.autoresizingMask = .FlexibleHeight | .FlexibleLeftMargin | .FlexibleRightMargin
    flexibleWidthHeightView.addSubview(flexibleHeightLeftRightView)
    
    // Left: Flexible Top / Bottom View
    let flexibleTopBottomSize = CGSize(width: leftRightWidth, height: defaultViewSideLength)
    let leftFlexibleTopBottomOrigin = CGPoint(x: padding, y: flexibleHeightLeftRightView.frame.midY - flexibleTopBottomSize.height / 2)
    let leftFlexibleTopBottomView = UIView(frame: CGRect(origin: leftFlexibleTopBottomOrigin, size: flexibleTopBottomSize))
    
    leftFlexibleTopBottomView.backgroundColor = UIColor.awesgreenColor()
    leftFlexibleTopBottomView.layer.borderWidth = borderWidth
    leftFlexibleTopBottomView.layer.cornerRadius = cornerRadius
    leftFlexibleTopBottomView.layer.borderColor = borderColor
    leftFlexibleTopBottomView.autoresizingMask = .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleRightMargin
    flexibleWidthHeightView.addSubview(leftFlexibleTopBottomView)
    
    // Right: Flexible Top / Bottom View
    let rightFlexibleTopBottomOrigin = CGPoint(x: flexibleWidthHeightView.bounds.width - padding - leftRightWidth, y: flexibleHeightLeftRightView.frame.midY - flexibleTopBottomSize.height / 2)
    let rightFlexibleTopBottomView = UIView(frame: CGRect(origin: rightFlexibleTopBottomOrigin, size: flexibleTopBottomSize))
    
    rightFlexibleTopBottomView.backgroundColor = UIColor.revertPinkColor()
    rightFlexibleTopBottomView.layer.borderWidth = borderWidth
    rightFlexibleTopBottomView.layer.borderColor = borderColor
    rightFlexibleTopBottomView.layer.cornerRadius = cornerRadius
    rightFlexibleTopBottomView.autoresizingMask = .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleLeftMargin
    flexibleWidthHeightView.addSubview(rightFlexibleTopBottomView)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.addSubViewsIfNeeded()
  }
}

