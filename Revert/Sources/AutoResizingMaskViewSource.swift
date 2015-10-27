//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AutoResizingMaskViewSource {
  private let padding: CGFloat = 20
  private let cornerRadius: CGFloat = 2
  private let borderWidth: CGFloat = 1
  private let borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.5).CGColor
  private let defaultViewSideLength: CGFloat = 50
  private let leftRightWidth: CGFloat = 80

  private let origin: CGPoint
  private let flexibleWidthHeightSize: CGSize
  private let flexibleTopBottomSize: CGSize

  init(bounds: CGRect) {
    self.flexibleWidthHeightSize = CGSize(
      width: bounds.width - (2 * self.padding),
      height: bounds.height - (2 * self.padding)
    )
    self.origin = CGPoint(x: self.padding, y: self.padding)
    self.flexibleTopBottomSize = CGSize(
      width: self.leftRightWidth,
      height: self.defaultViewSideLength
    )
  }

  private func bakeViewWithFrame(frame: CGRect) -> UIView {
    let view = UIView(frame: frame)
    view.layer.cornerRadius = self.cornerRadius
    view.layer.borderWidth = self.borderWidth
    view.layer.borderColor = self.borderColor
    return view
  }

  private(set) lazy var flexibleWidthHeightView: UIView = {
    // Back: Flexible Height / Width View
    let frame = CGRect(origin: self.origin, size: self.flexibleWidthHeightSize)
    let flexibleWidthHeightView = self.bakeViewWithFrame(frame)

    flexibleWidthHeightView.backgroundColor = UIColor.clearColor()
    flexibleWidthHeightView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    flexibleWidthHeightView.layer.borderColor = UIColor.whiteColor().CGColor
    return flexibleWidthHeightView
  }()

  private(set) lazy var flexibleWidthView: UIView = {
    let flexibleWidthSize = CGSize(
      width: self.flexibleWidthHeightSize.width - (2 * self.padding),
      height: self.defaultViewSideLength
    )
    let frame = CGRect(origin: self.origin, size: flexibleWidthSize)
    let flexibleWidthView = self.bakeViewWithFrame(frame)

    flexibleWidthView.backgroundColor = UIColor.revertDarkblueColor()
    flexibleWidthView.autoresizingMask = .FlexibleWidth
    return flexibleWidthView
  }()

  private(set) lazy var flexibleHeightLeftRightView: UIView = {
    let flexibleHeightLeftRightSize = CGSize(
      width: self.defaultViewSideLength,
      height: self.flexibleWidthHeightSize.height - self.flexibleWidthView.frame.maxY - (2 * self.padding)
    )

    let flexibleHeightLeftRightOrigin = CGPoint(
      x: (self.flexibleWidthHeightView.bounds.width - flexibleHeightLeftRightSize.width) / 2,
      y: self.flexibleWidthView.frame.maxY + self.padding
    )

    let frame = CGRect(origin: flexibleHeightLeftRightOrigin, size: flexibleHeightLeftRightSize)
    let flexibleHeightLeftRightView = self.bakeViewWithFrame(frame)

    flexibleHeightLeftRightView.backgroundColor = UIColor.revertOrangeColor()
    flexibleHeightLeftRightView.autoresizingMask = [.FlexibleHeight, .FlexibleLeftMargin, .FlexibleRightMargin]
    return flexibleHeightLeftRightView
  }()

  private(set) lazy var leftFlexibleTopBottomView: UIView = {
    let leftFlexibleTopBottomOrigin = CGPoint(
      x: self.padding,
      y: self.flexibleHeightLeftRightView.frame.midY - self.flexibleTopBottomSize.height / 2
    )
    let frame = CGRect(origin: leftFlexibleTopBottomOrigin, size: self.flexibleTopBottomSize)
    let leftFlexibleTopBottomView = self.bakeViewWithFrame(frame)

    leftFlexibleTopBottomView.backgroundColor = UIColor.awesgreenColor()
    leftFlexibleTopBottomView.autoresizingMask = [.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleRightMargin]
    return leftFlexibleTopBottomView
  }()

  private(set) lazy var rightFlexibleTopBottomView: UIView = {
    let rightFlexibleTopBottomOrigin = CGPoint(x:
      self.flexibleWidthHeightView.bounds.width - self.padding - self.leftRightWidth,
      y: self.flexibleHeightLeftRightView.frame.midY - self.flexibleTopBottomSize.height / 2
    )

    let frame = CGRect(origin: rightFlexibleTopBottomOrigin, size: self.flexibleTopBottomSize)
    let rightFlexibleTopBottomView = self.bakeViewWithFrame(frame)

    rightFlexibleTopBottomView.backgroundColor = UIColor.revertPinkColor()
    rightFlexibleTopBottomView.autoresizingMask = [.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleLeftMargin]
    return rightFlexibleTopBottomView
  }()
}

