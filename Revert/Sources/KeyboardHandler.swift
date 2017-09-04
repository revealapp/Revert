//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class KeyboardHandler: NSObject {
  weak var scrollView: UIScrollView?
  weak var viewController: UIViewController?

  override init() {
    super.init()

    self.registerNotifications()
  }

  deinit {
    self.unregisterNotifications()
  }

  private func registerNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShowHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShowHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }

  private func unregisterNotifications() {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }

  @objc func keyboardWillShowHideNotification(_ notification: Notification) {
    guard
      let scrollView = self.scrollView,
      let scrollViewSuperview = scrollView.superview,
      let viewController = self.viewController,
      let animationDuration = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
      let animationCurveInt = (notification as NSNotification).userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Int,
      let animationCurve = UIViewAnimationCurve(rawValue: animationCurveInt),
      let keyboardFrameValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
      else {
      return
    }

    let keyboardFrame = keyboardFrameValue.cgRectValue
    let keyboardFrameInView = scrollViewSuperview.convert(keyboardFrame, from: nil)
    let bottomInset = max(scrollView.frame.maxY - keyboardFrameInView.minY, viewController.bottomLayoutGuide.length)
    let animationOptions = UIViewAnimationOptions(rawValue: UInt(animationCurve.rawValue) << 16)

    var contentInsets = scrollView.contentInset
    var scrollIndicatorInsets = scrollView.scrollIndicatorInsets

    contentInsets.bottom = bottomInset
    scrollIndicatorInsets.bottom = bottomInset

    UIView.animate(withDuration: animationDuration, delay: 0, options: animationOptions, animations: {
      scrollView.contentInset = contentInsets
      scrollView.scrollIndicatorInsets = scrollIndicatorInsets
    }, completion: nil)
  }
}
