//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class KeyboardHandler: NSObject, KeyboardHandlerProtocol {
  weak var scrollView: UIScrollView?
  weak var viewController: UIViewController?

  override init() {
    super.init()

    self.registerNotifications()
  }

  deinit {
    self.unregisterNotifications()
  }
}

// MARK:- Keyboard notifications
// Keyboard notifications are not available on tvOS, so we have to keep everything related to them separate.
// The `KeyboardHandlerProtocol` protocol and extension ensure compatibility with tvOS.
// The `KeyboardHandler` extension makes sure keyboard notifications are only handled on iOS.

protocol KeyboardHandlerProtocol {
  func registerNotifications()
  
  func unregisterNotifications()
  
  func keyboardWillShowHideNotification()
}

extension KeyboardHandlerProtocol {
  func registerNotifications() {
    // This empty method simulates an optional protocol method like we have in ObjC.
  }
  
  func unregisterNotifications() {
    // This empty method simulates an optional protocol method like we have in ObjC.
  }
  
  func keyboardWillShowHideNotification() {
    // This empty method simulates an optional protocol method like we have in ObjC.
  }
}

#if os(iOS)
  extension KeyboardHandler {
    func keyboardWillShowHideNotification(notification: NSNotification) {
      guard let scrollView = self.scrollView,
        scrollViewSuperview = scrollView.superview,
        viewController = self.viewController,
        animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval,
        animationCurveInt = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Int,
        animationCurve = UIViewAnimationCurve(rawValue: animationCurveInt),
        keyboardFrameValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
          return
      }
      
      let keyboardFrame = keyboardFrameValue.CGRectValue()
      let keyboardFrameInView = scrollViewSuperview.convertRect(keyboardFrame, fromView: nil)
      let bottomInset = max(scrollView.frame.maxY - keyboardFrameInView.minY, viewController.bottomLayoutGuide.length)
      let animationOptions = UIViewAnimationOptions(rawValue: UInt(animationCurve.rawValue) << 16)
      
      var contentInsets = scrollView.contentInset
      var scrollIndicatorInsets = scrollView.scrollIndicatorInsets
      
      contentInsets.bottom = bottomInset
      scrollIndicatorInsets.bottom = bottomInset
      
      UIView.animateWithDuration(animationDuration, delay: 0, options: animationOptions, animations: {
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = scrollIndicatorInsets
        }, completion: nil)
    }
  }
#endif
