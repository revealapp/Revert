//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class AutoResizingMaskViewSource {

  init(bounds: CGRect) {
    self.flexibleWidthHeightSize = CGSize(
      width: bounds.width - (2 * type(of: self).horizontalPadding),
      height: bounds.height - (2 * type(of: self).verticalPadding)
    )
    self.outerOrigin = CGPoint(x: type(of: self).horizontalPadding, y: type(of: self).verticalPadding)
    self.innerOrigin = CGPoint(x: type(of: self).innerPadding, y: type(of: self).innerPadding)
    self.flexibleTopBottomSize = CGSize(
      width: type(of: self).leftRightWidth,
      height: type(of: self).defaultViewSideLength
    )
  }

  // MARK: Private

  fileprivate static let innerPadding: CGFloat = 20
  fileprivate static let cornerRadius: CGFloat = 2
  fileprivate static let borderWidth: CGFloat = 1
  fileprivate static let borderColor = UIColor.borderColor().withAlphaComponent(0.5).cgColor
  fileprivate static let defaultViewSideLength: CGFloat = 50
  fileprivate static let leftRightWidth: CGFloat = 80

  fileprivate let outerOrigin: CGPoint
  fileprivate let innerOrigin: CGPoint
  fileprivate let flexibleWidthHeightSize: CGSize
  fileprivate let flexibleTopBottomSize: CGSize

  fileprivate static var horizontalPadding: CGFloat = {
    #if os(tvOS)
      return CGFloat(90)
    #else
      return CGFloat(20)
    #endif
  }()

  fileprivate static let verticalPadding: CGFloat = {
    #if os(tvOS)
      return CGFloat(60)
    #else
      return CGFloat(20)
    #endif
  }()

  fileprivate(set) lazy var flexibleWidthHeightView: UIView = {
    // Back: Flexible Height / Width View
    let frame = CGRect(origin: self.outerOrigin, size: self.flexibleWidthHeightSize)
    let flexibleWidthHeightView = self.bakeViewWithFrame(frame)

    flexibleWidthHeightView.backgroundColor = UIColor.clear
    flexibleWidthHeightView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    flexibleWidthHeightView.layer.borderColor = UIColor.borderColor().cgColor
    return flexibleWidthHeightView
  }()

  fileprivate(set) lazy var flexibleWidthView: UIView = {
    let flexibleWidthSize = CGSize(
      width: self.flexibleWidthHeightSize.width - (2 * type(of: self).innerPadding),
      height: type(of: self).defaultViewSideLength
    )
    let frame = CGRect(origin: self.innerOrigin, size: flexibleWidthSize)
    let flexibleWidthView = self.bakeViewWithFrame(frame)

    flexibleWidthView.backgroundColor = UIColor.revertDarkblueColor()
    flexibleWidthView.autoresizingMask = .flexibleWidth
    return flexibleWidthView
  }()

  fileprivate(set) lazy var flexibleHeightLeftRightView: UIView = {
    let flexibleHeightLeftRightSize = CGSize(
      width: type(of: self).defaultViewSideLength,
      height: self.flexibleWidthHeightSize.height - self.flexibleWidthView.frame.maxY - (2 * type(of: self).innerPadding)
    )

    let flexibleHeightLeftRightOrigin = CGPoint(
      x: (self.flexibleWidthHeightView.bounds.width - flexibleHeightLeftRightSize.width) / 2,
      y: self.flexibleWidthView.frame.maxY + type(of: self).innerPadding
    )

    let frame = CGRect(origin: flexibleHeightLeftRightOrigin, size: flexibleHeightLeftRightSize)
    let flexibleHeightLeftRightView = self.bakeViewWithFrame(frame)

    flexibleHeightLeftRightView.backgroundColor = UIColor.revertOrangeColor()
    flexibleHeightLeftRightView.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin]
    return flexibleHeightLeftRightView
  }()

  fileprivate(set) lazy var leftFlexibleTopBottomView: UIView = {
    let leftFlexibleTopBottomOrigin = CGPoint(
      x: type(of: self).innerPadding,
      y: self.flexibleHeightLeftRightView.frame.midY - self.flexibleTopBottomSize.height / 2
    )
    let frame = CGRect(origin: leftFlexibleTopBottomOrigin, size: self.flexibleTopBottomSize)
    let leftFlexibleTopBottomView = self.bakeViewWithFrame(frame)

    leftFlexibleTopBottomView.backgroundColor = UIColor.awesgreenColor()
    leftFlexibleTopBottomView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleRightMargin]
    return leftFlexibleTopBottomView
  }()

  fileprivate(set) lazy var rightFlexibleTopBottomView: UIView = {
    let rightFlexibleTopBottomOrigin = CGPoint(
      x: self.flexibleWidthHeightView.bounds.width - type(of: self).innerPadding - type(of: self).leftRightWidth,
      y: self.flexibleHeightLeftRightView.frame.midY - self.flexibleTopBottomSize.height / 2
    )

    let frame = CGRect(origin: rightFlexibleTopBottomOrigin, size: self.flexibleTopBottomSize)
    let rightFlexibleTopBottomView = self.bakeViewWithFrame(frame)

    rightFlexibleTopBottomView.backgroundColor = UIColor.revertPinkColor()
    rightFlexibleTopBottomView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin]
    return rightFlexibleTopBottomView
  }()

  fileprivate func bakeViewWithFrame(_ frame: CGRect) -> UIView {
    let view = UIView(frame: frame)
    view.layer.cornerRadius = type(of: self).cornerRadius
    view.layer.borderWidth = type(of: self).borderWidth
    view.layer.borderColor = type(of: self).borderColor
    return view
  }
}
