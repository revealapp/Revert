//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AutoResizingMaskViewController: ViewController {

  @IBOutlet weak var outterView: UIView!
  
  private var viewsWereSetup = false
  
  private func addSubViewsIfNeeded() {
    // Only perform this action once
    if self.viewsWereSetup {
      return
    }
    self.viewsWereSetup = true
    
    let padding:CGFloat = 20.0
    let cornerRadius:CGFloat = 2.0
    let borderWidth:CGFloat = 1.0
    let borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.15)
    let defaultViewSideLength: CGFloat = 50
    let leftRightWidth: CGFloat = 80
    
    // Back: Flexible Height / Width View
    let origin = CGPoint(x: padding, y: padding)
    let flexibleWidthHeightSize = CGSize(width: self.outterView.bounds.width - (2.0 * padding), height: self.outterView.bounds.height - (2.0 * padding))
    let flexibleWidthHeightView = UIView(frame: CGRect(origin: origin, size: flexibleWidthHeightSize))
    
    flexibleWidthHeightView.backgroundColor = UIColor.clearColor()
    flexibleWidthHeightView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
    flexibleWidthHeightView.cornerRadius = cornerRadius
    flexibleWidthHeightView.borderWidth = borderWidth
    flexibleWidthHeightView.borderColor = UIColor.whiteColor()
    self.outterView.addSubview(flexibleWidthHeightView)
    
    // Top: Flexible Width View
    let flexibleWidthSize = CGSize(width: flexibleWidthHeightSize.width - (2.0 * padding), height: defaultViewSideLength)
    let flexibleWidthView = UIView(frame: CGRect(origin: origin, size: flexibleWidthSize))
    
    flexibleWidthView.backgroundColor = UIColor.revertDarkblueColor()
    flexibleWidthView.autoresizingMask = .FlexibleWidth
    flexibleWidthView.cornerRadius = cornerRadius
    flexibleWidthView.borderWidth = borderWidth
    flexibleWidthView.borderColor = borderColor
    
    flexibleWidthHeightView.addSubview(flexibleWidthView)
    
    // Middle: Flexible Height / Left / Right View
    let flexibleHeightLeftRightSize = CGSize(width: defaultViewSideLength, height: flexibleWidthHeightSize.height - flexibleWidthView.frame.maxY - (2.0 * padding))
    let flexibleHeightLeftRightOrigin = CGPoint(x: (flexibleWidthHeightView.bounds.width - flexibleHeightLeftRightSize.width) / 2.0, y: flexibleWidthView.frame.maxY + padding)
    let flexibleHeightLeftRightView = UIView(frame: CGRect(origin: flexibleHeightLeftRightOrigin, size: flexibleHeightLeftRightSize))
    
    flexibleHeightLeftRightView.backgroundColor = UIColor.revertOrangeColor()
    flexibleHeightLeftRightView.cornerRadius = cornerRadius
    flexibleHeightLeftRightView.borderWidth = borderWidth
    flexibleHeightLeftRightView.borderColor = borderColor
    flexibleHeightLeftRightView.autoresizingMask = .FlexibleHeight | .FlexibleLeftMargin | .FlexibleRightMargin
    flexibleWidthHeightView.addSubview(flexibleHeightLeftRightView)
    
    // Left: Flexible Top / Bottom View
    let flexibleTopBottomSize = CGSize(width: leftRightWidth, height: defaultViewSideLength)
    let leftFlexibleTopBottomOrigin = CGPoint(x: padding, y: flexibleHeightLeftRightView.frame.midY - flexibleTopBottomSize.height / 2.0)
    let leftFlexibleTopBottomView = UIView(frame: CGRect(origin: leftFlexibleTopBottomOrigin, size: flexibleTopBottomSize))
    
    leftFlexibleTopBottomView.backgroundColor = UIColor.awesgreenColor()
    leftFlexibleTopBottomView.borderWidth = borderWidth
    leftFlexibleTopBottomView.cornerRadius = cornerRadius
    leftFlexibleTopBottomView.borderColor = borderColor
    leftFlexibleTopBottomView.autoresizingMask = .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleRightMargin
    flexibleWidthHeightView.addSubview(leftFlexibleTopBottomView)
    
    // Right: Flexible Top / Bottom View
    let rightFlexibleTopBottomOrigin = CGPoint(x: flexibleWidthHeightView.bounds.width - padding - leftRightWidth, y: flexibleHeightLeftRightView.frame.midY - flexibleTopBottomSize.height / 2.0)
    let rightFlexibleTopBottomView = UIView(frame: CGRect(origin: rightFlexibleTopBottomOrigin, size: flexibleTopBottomSize))
    
    rightFlexibleTopBottomView.backgroundColor = UIColor.revertPinkColor()
    rightFlexibleTopBottomView.borderWidth = borderWidth
    rightFlexibleTopBottomView.borderColor = borderColor
    rightFlexibleTopBottomView.cornerRadius = cornerRadius
    rightFlexibleTopBottomView.autoresizingMask = .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleLeftMargin
    flexibleWidthHeightView.addSubview(rightFlexibleTopBottomView)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.addSubViewsIfNeeded()
  }
}

