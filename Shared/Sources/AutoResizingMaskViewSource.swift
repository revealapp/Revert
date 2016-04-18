//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class AutoResizingMaskViewSource {
  init(bounds: CGRect) {
    self.flexibleWidthHeightSize = CGSize(
      width: bounds.width - (2 * self.dynamicType.horizontalPadding),
      height: bounds.height - (2 * self.dynamicType.verticalPadding)
    )
    self.outerOrigin = CGPoint(x: self.dynamicType.horizontalPadding, y: self.dynamicType.verticalPadding)
    self.innerOrigin = CGPoint(x: self.dynamicType.innerPadding, y: self.dynamicType.innerPadding)
    self.flexibleTopBottomSize = CGSize(
      width: self.dynamicType.leftRightWidth,
      height: self.dynamicType.defaultViewSideLength
    )
  }

  // MARK: Private

  private static let innerPadding: CGFloat = 20
  private static let cornerRadius: CGFloat = 2
  private static let borderWidth: CGFloat = 1
  private static let borderColor = UIColor.borderColor().colorWithAlphaComponent(0.5).CGColor
  private static let defaultViewSideLength: CGFloat = 50
  private static let leftRightWidth: CGFloat = 80

  private let outerOrigin: CGPoint
  private let innerOrigin: CGPoint
  private let flexibleWidthHeightSize: CGSize
  private let flexibleTopBottomSize: CGSize

  private static var horizontalPadding: CGFloat = {
    #if os(tvOS)
      return CGFloat(90)
    #else
      return CGFloat(20)
    #endif
  }()

  private static let verticalPadding: CGFloat = {
    #if os(tvOS)
      return CGFloat(60)
    #else
      return CGFloat(20)
    #endif
  }()

  private(set) lazy var flexibleWidthHeightView: UIView = {
    // Back: Flexible Height / Width View
    let frame = CGRect(origin: self.outerOrigin, size: self.flexibleWidthHeightSize)
    let flexibleWidthHeightView = self.bakeViewWithFrame(frame)

    flexibleWidthHeightView.backgroundColor = UIColor.clearColor()
    flexibleWidthHeightView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    flexibleWidthHeightView.layer.borderColor = UIColor.borderColor().CGColor
    return flexibleWidthHeightView
  }()

  private(set) lazy var flexibleWidthView: UIView = {
    let flexibleWidthSize = CGSize(
      width: self.flexibleWidthHeightSize.width - (2 * self.dynamicType.innerPadding),
      height: self.dynamicType.defaultViewSideLength
    )
    let frame = CGRect(origin: self.innerOrigin, size: flexibleWidthSize)
    let flexibleWidthView = self.bakeViewWithFrame(frame)

    flexibleWidthView.backgroundColor = UIColor.revertDarkblueColor()
    flexibleWidthView.autoresizingMask = .FlexibleWidth
    return flexibleWidthView
  }()

  private(set) lazy var flexibleHeightLeftRightView: UIView = {
    let flexibleHeightLeftRightSize = CGSize(
      width: self.dynamicType.defaultViewSideLength,
      height: self.flexibleWidthHeightSize.height - self.flexibleWidthView.frame.maxY - (2 * self.dynamicType.innerPadding)
    )

    let flexibleHeightLeftRightOrigin = CGPoint(
      x: (self.flexibleWidthHeightView.bounds.width - flexibleHeightLeftRightSize.width) / 2,
      y: self.flexibleWidthView.frame.maxY + self.dynamicType.innerPadding
    )

    let frame = CGRect(origin: flexibleHeightLeftRightOrigin, size: flexibleHeightLeftRightSize)
    let flexibleHeightLeftRightView = self.bakeViewWithFrame(frame)

    flexibleHeightLeftRightView.backgroundColor = UIColor.revertOrangeColor()
    flexibleHeightLeftRightView.autoresizingMask = [.FlexibleHeight, .FlexibleLeftMargin, .FlexibleRightMargin]
    return flexibleHeightLeftRightView
  }()

  private(set) lazy var leftFlexibleTopBottomView: UIView = {
    let leftFlexibleTopBottomOrigin = CGPoint(
      x: self.dynamicType.innerPadding,
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
      self.flexibleWidthHeightView.bounds.width - self.dynamicType.innerPadding - self.dynamicType.leftRightWidth,
      y: self.flexibleHeightLeftRightView.frame.midY - self.flexibleTopBottomSize.height / 2
    )

    let frame = CGRect(origin: rightFlexibleTopBottomOrigin, size: self.flexibleTopBottomSize)
    let rightFlexibleTopBottomView = self.bakeViewWithFrame(frame)

    rightFlexibleTopBottomView.backgroundColor = UIColor.revertPinkColor()
    rightFlexibleTopBottomView.autoresizingMask = [.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleLeftMargin]
    return rightFlexibleTopBottomView
  }()

  private func bakeViewWithFrame(frame: CGRect) -> UIView {
    let view = UIView(frame: frame)
    view.layer.cornerRadius = self.dynamicType.cornerRadius
    view.layer.borderWidth = self.dynamicType.borderWidth
    view.layer.borderColor = self.dynamicType.borderColor
    return view
  }
}
