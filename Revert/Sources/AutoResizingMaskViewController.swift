//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class AutoResizingMaskViewController: UIViewController {
  
  @IBOutlet weak var outterView: UIView!
  
  private var viewsWereSetup = false
  
  private func addSubViewsIfNeeded() {
    
    if self.viewsWereSetup {
      return
    }
    self.viewsWereSetup = true
    
    let padding:CGFloat = 20.0
    
    // Back: Flexible Height / Width View
    let origin = CGPoint(x: padding, y: padding)
    let flexibleWidthHeightSize = CGSize(width: self.outterView.bounds.width - (2.0 * padding), height: self.outterView.bounds.height - (2.0 * padding))
    let flexibleWidthHeightView = UIView(frame: CGRect(origin: origin, size: flexibleWidthHeightSize))
    
    flexibleWidthHeightView.backgroundColor = UIColor.clearColor()
    flexibleWidthHeightView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
    flexibleWidthHeightView.layer.cornerRadius = 2.0
    flexibleWidthHeightView.borderWidth = 1.0
    flexibleWidthHeightView.borderColor = UIColor.whiteColor()
    self.outterView.addSubview(flexibleWidthHeightView)
    
    // Top: Flexible Width View
    let flexibleWidthSize = CGSize(width: flexibleWidthHeightSize.width - (2.0 * padding), height: 50.0)
    let flexibleWidthView = UIView(frame: CGRect(origin: origin, size: flexibleWidthSize))
    
    flexibleWidthView.backgroundColor = UIColor.revertDarkblueColor()
    flexibleWidthView.autoresizingMask = .FlexibleWidth
    flexibleWidthView.layer.cornerRadius = 2.0
    flexibleWidthView.borderWidth = 1.0
    flexibleWidthView.borderColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.15)
    
    flexibleWidthHeightView.addSubview(flexibleWidthView)
    
    // Middle: Flexible Height / Left / Right View
    let flexibleHeightLeftRightSize = CGSize(width: 50.0, height: flexibleWidthHeightSize.height - flexibleWidthView.frame.maxY - (2.0 * padding))
    let flexibleHeightLeftRightOrigin = CGPoint(x: (flexibleWidthHeightView.bounds.width - flexibleHeightLeftRightSize.width) / 2.0, y: flexibleWidthView.frame.maxY + padding)
    let flexibleHeightLeftRightView = UIView(frame: CGRect(origin: flexibleHeightLeftRightOrigin, size: flexibleHeightLeftRightSize))
    
    flexibleHeightLeftRightView.backgroundColor = UIColor.revertOrangeColor()
    flexibleHeightLeftRightView.layer.cornerRadius = 2.0
    flexibleHeightLeftRightView.borderWidth = 1.0
    flexibleHeightLeftRightView.borderColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.15)
    flexibleHeightLeftRightView.autoresizingMask = .FlexibleHeight | .FlexibleLeftMargin | .FlexibleRightMargin
    flexibleWidthHeightView.addSubview(flexibleHeightLeftRightView)
    
    // Left: Flexible Top / Bottom View
    let flexibleTopBottomSize = CGSize(width: (flexibleWidthHeightSize.width - flexibleHeightLeftRightSize.width) / 2.0 - (2.0 * padding), height: 50.0)
    let leftFlexibleTopBottomOrigin = CGPoint(x: padding, y: flexibleHeightLeftRightView.frame.midY - flexibleTopBottomSize.height / 2.0)
    let leftFlexibleTopBottomView = UIView(frame: CGRect(origin: leftFlexibleTopBottomOrigin, size: flexibleTopBottomSize))
    
    leftFlexibleTopBottomView.backgroundColor = UIColor.awesgreenColor()
    leftFlexibleTopBottomView.borderWidth = 1.0
    leftFlexibleTopBottomView.layer.cornerRadius = 2.0
    leftFlexibleTopBottomView.borderColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.15)
    leftFlexibleTopBottomView.autoresizingMask = .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleRightMargin
    flexibleWidthHeightView.addSubview(leftFlexibleTopBottomView)
    
    // Right: Flexible Top / Bottom View
    let rightFlexibleTopBottomOrigin = CGPoint(x: flexibleHeightLeftRightView.frame.midX + flexibleHeightLeftRightSize.width / 2.0 + padding, y: flexibleHeightLeftRightView.frame.midY - flexibleTopBottomSize.height / 2.0)
    let rightFlexibleTopBottomView = UIView(frame: CGRect(origin: rightFlexibleTopBottomOrigin, size: flexibleTopBottomSize))
    
    rightFlexibleTopBottomView.backgroundColor = UIColor.revertPinkColor()
    rightFlexibleTopBottomView.borderWidth = 1.0
    rightFlexibleTopBottomView.borderColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.15)
    rightFlexibleTopBottomView.layer.cornerRadius = 2.0
    rightFlexibleTopBottomView.autoresizingMask = .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleLeftMargin
    flexibleWidthHeightView.addSubview(rightFlexibleTopBottomView)
}
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.addSubViewsIfNeeded()
  }
}
