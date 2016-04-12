//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

extension UIColor {
  static func whitesmokeColor() -> UIColor {
    return UIColor(red: 254 / 255, green: 254 / 255, blue: 254 / 255, alpha: 1)
  }

  static func awesgreenColor() -> UIColor {
    return UIColor(red: 46 / 255, green: 213 / 255, blue: 195 / 255, alpha: 1)
  }

  static func revertOrangeColor() -> UIColor {
    return UIColor(red: 0.992, green: 0.663, blue: 0.161, alpha: 1)
  }

  static func revertPinkColor() -> UIColor {
    return UIColor(red:0.81, green:0.325, blue:1, alpha:1)
  }

  static func revertDarkblueColor() -> UIColor {
    return UIColor(red:0.217, green:0.372, blue:1, alpha:1)
  }

  static func revertLightBlackColor() -> UIColor {
    return UIColor(red:0.156, green:0.156, blue:0.156, alpha:1)
  }

  static func revertTintColor() -> UIColor {
    return UIColor(red: 53 / 255, green: 174 / 255, blue: 237 / 255, alpha: 1)
  }

  static func graySelectionColor() -> UIColor {
    return UIColor(white: 215 / 255, alpha: 1)
  }

  static func borderColor() -> UIColor {
    #if os(tvOS)
      return UIColor.blackColor()
    #else
      return UIColor.whiteColor()
    #endif
  }
}
