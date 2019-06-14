//
//  VisualEffectViewController.swift
//  Revert-iOS
//
//  Created by june chen on 12/6/19.
//  Copyright © 2019 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class VisualEffectViewController: RevertViewController {

  // MARK: - Types

  fileprivate enum Corner: CaseIterable {
    case bottomRight
    case bottomLeft
    case topLeft
    case topRight
  }

  // MARK: - UIViewController

  override var preferredFocusedView: UIView? {
    return self.scrollView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    #if os(tvOS)
    self.scrollView.panGestureRecognizer.allowedTouchTypes = [UITouch.TouchType.indirect.rawValue as NSNumber]
    #endif
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.scrollView.flashScrollIndicators()

    if !self.isAnimationLoaded {
      self.performMoveAnimation()
      self.isAnimationLoaded = true
    }
  }

  // MARK: - Private

  @IBOutlet private weak var scrollView: RevertFocusableScrollView!
  private var isAnimationLoaded = false

  private func performMoveAnimation() {
    self.move(to: Corner.allCases.makeIterator())
  }

  private func move(to pathIterator: IndexingIterator<[Corner]>) {
    var pathIterator = pathIterator
    guard let corner = pathIterator.next() else {
      return
    }

    UIView.animate(
      withDuration: 6,
      animations: {
        // Something
        self.scrollView.setContentOffset(self.scrollView.contentOffset(for: corner), animated: false)
      },
      completion: { _ in
        self.move(to: pathIterator)
      }
    )
  }
}

private extension UIScrollView {
  func contentOffset(for corner: VisualEffectViewController.Corner) -> CGPoint {
    switch corner {
    case .bottomRight:
      return CGPoint(x: rightEdge, y: bottomEdge)
    case .bottomLeft:
      return CGPoint(x: leftEdge, y: bottomEdge)
    case .topLeft:
      return CGPoint(x: leftEdge, y: topEdge)
    case .topRight:
      return CGPoint(x: rightEdge, y: topEdge)
    }
  }

  var bottomEdge: CGFloat {
    return self.contentSize.height - self.bounds.size.height + self.contentInset.top
  }

  var rightEdge: CGFloat {
    return self.contentSize.width - self.bounds.size.width + self.contentInset.left
  }

  var topEdge: CGFloat {
    return self.contentInset.top
  }

  var leftEdge: CGFloat {
    return self.contentInset.left
  }
}
