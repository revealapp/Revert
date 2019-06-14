//
//  VisualEffectViewController.swift
//  Revert-iOS
//
//  Created by june chen on 12/6/19.
//  Copyright © 2019 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class VisualEffectViewController: RevertViewController {

  private var path: [CGPoint] = []

  override var preferredFocusedView: UIView? {
    return self.scrollView
  }

  // MARK: Private

  @IBOutlet weak var scrollView: RevertFocusableScrollView!
  private var isAnimationLoaded = false

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.scrollView.flashScrollIndicators()

    if !self.isAnimationLoaded {
      self.performMoveAnimation()
      self.isAnimationLoaded = true
    }
  }

  private func performMoveAnimation() {
    let bottomRight = CGPoint(x: self.scrollView.rightEdge, y: self.scrollView.bottomEdge)
    let bottomLeft = CGPoint(x: self.scrollView.leftEdge, y: self.scrollView.bottomEdge)
    let topLeft = CGPoint(x: self.scrollView.leftEdge, y: self.scrollView.topEdge)
    let topRight = CGPoint(x: self.scrollView.rightEdge, y: self.scrollView.topEdge)

    self.path = [bottomRight, topRight, bottomLeft, topLeft]

    self.move(to: 0)
  }

  private func move(to pathIndex: Int) {
    if !self.path.indices.contains(pathIndex) {
      return
    }

    let point = self.path[pathIndex]
    UIView.animate(withDuration: 6,
                   animations: {
                    self.scrollView.setContentOffset(point, animated: false)
    },
                   completion: { _ in
                    self.move(to: pathIndex + 1)
    })
  }
}

#if os(tvOS)

extension VisualEffectViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    self.scrollView.panGestureRecognizer.allowedTouchTypes = [UITouch.TouchType.indirect.rawValue as NSNumber]
  }
}
#endif

private extension UIScrollView {
  var bottomEdge: CGFloat {
    return self.contentSize.height - self.bounds.size.height + self.contentInset.bottom
  }

  var rightEdge: CGFloat {
    return self.contentSize.width - self.bounds.size.width + self.contentInset.right
  }

  var topEdge: CGFloat {
    return self.contentInset.top
  }

  var leftEdge: CGFloat {
    return self.contentInset.left
  }
}
