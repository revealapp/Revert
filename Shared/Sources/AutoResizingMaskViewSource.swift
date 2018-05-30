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

  private static let innerPadding: CGFloat = 20
  private static let cornerRadius: CGFloat = 2
  private static let borderWidth: CGFloat = 1
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

    flexibleWidthHeightView.backgroundColor = UIColor.clear
    flexibleWidthHeightView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return flexibleWidthHeightView
  }()

  private(set) lazy var flexibleWidthView: UIView = {
    let flexibleWidthSize = CGSize(
      width: self.flexibleWidthHeightSize.width - (2 * type(of: self).innerPadding),
      height: type(of: self).defaultViewSideLength
    )
    let frame = CGRect(origin: self.innerOrigin, size: flexibleWidthSize)
    let flexibleWidthView = self.bakeViewWithFrame(frame)

    flexibleWidthView.backgroundColor = .revertDarkBlue
    flexibleWidthView.autoresizingMask = .flexibleWidth
    return flexibleWidthView
  }()

  private(set) lazy var flexibleHeightLeftRightView: UIView = {
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

    flexibleHeightLeftRightView.backgroundColor = .revertOrange
    flexibleHeightLeftRightView.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin]
    return flexibleHeightLeftRightView
  }()

  private(set) lazy var leftFlexibleTopBottomView: UIView = {
    let leftFlexibleTopBottomOrigin = CGPoint(
      x: type(of: self).innerPadding,
      y: self.flexibleHeightLeftRightView.frame.midY - self.flexibleTopBottomSize.height / 2
    )
    let frame = CGRect(origin: leftFlexibleTopBottomOrigin, size: self.flexibleTopBottomSize)
    let leftFlexibleTopBottomView = self.bakeViewWithFrame(frame)

    leftFlexibleTopBottomView.backgroundColor = .awesGreen
    leftFlexibleTopBottomView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleRightMargin]
    return leftFlexibleTopBottomView
  }()

  private(set) lazy var rightFlexibleTopBottomView: UIView = {
    let rightFlexibleTopBottomOrigin = CGPoint(
      x: self.flexibleWidthHeightView.bounds.width - type(of: self).innerPadding - type(of: self).leftRightWidth,
      y: self.flexibleHeightLeftRightView.frame.midY - self.flexibleTopBottomSize.height / 2
    )

    let frame = CGRect(origin: rightFlexibleTopBottomOrigin, size: self.flexibleTopBottomSize)
    let rightFlexibleTopBottomView = self.bakeViewWithFrame(frame)

    rightFlexibleTopBottomView.backgroundColor = .revertPink
    rightFlexibleTopBottomView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin]
    return rightFlexibleTopBottomView
  }()

  private func bakeViewWithFrame(_ frame: CGRect) -> UserInterfaceStyleAwareView {
    let view = UserInterfaceStyleAwareView(frame: frame)
    view.layer.cornerRadius = type(of: self).cornerRadius
    view.layer.borderWidth = type(of: self).borderWidth
    return view
  }
}

private class UserInterfaceStyleAwareView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.layer.borderColor = self.borderColor
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private

  private var borderColor: CGColor {

    #if os(tvOS)

      guard #available(tvOS 10.0, *) else {
        return UIColor.black.cgColor
      }

      switch self.traitCollection.userInterfaceStyle {
      case .dark:
        return UIColor.white.cgColor
      case .light, .unspecified:
        return UIColor.black.cgColor
      }

    #else

      return UIColor.white.cgColor

    #endif

  }

  #if os(tvOS)

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
      super.traitCollectionDidChange(previousTraitCollection)

      guard #available(tvOS 10.0, *) else { return }
      if self.traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
        self.layer.borderColor = self.borderColor
      }
    }

  #endif
}
