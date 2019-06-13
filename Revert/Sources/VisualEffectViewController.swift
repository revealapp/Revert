//
//  VisualEffectViewController.swift
//  Revert-iOS
//
//  Created by june chen on 12/6/19.
//  Copyright © 2019 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class VisualEffectViewController: ScrollViewController {

  private var path: [CGPoint] = []

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let bottomEdge = self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom
    let rightEdge = self.scrollView.contentSize.width - self.scrollView.bounds.size.width + self.scrollView.contentInset.right
    let topEdge = self.scrollView.contentInset.top
    let leftEdge = self.scrollView.contentInset.left

    let bottomRight = CGPoint(x: rightEdge, y: bottomEdge)
    let topLeft = CGPoint(x: rightEdge, y: bottomEdge)
    let topRight = CGPoint(x: rightEdge, y: topEdge)

    let bottomLeft = CGPoint(x: 0, y: bottomEdge)
    let bottomMiddle = CGPoint(x: self.scrollView.contentSize.width / 2, y: bottomEdge)


    self.path = [bottomRight, topRight]

    self.move(to: 0)
  }

  func move(to pathIndex: Int) {
    if !self.path.indices.contains(pathIndex) {
      return
    }

    let point = self.path[pathIndex]
    UIView.animate(withDuration: 6, animations: {

      self.scrollView.setContentOffset(point, animated: false)

    }) { finished in
      self.move(to: pathIndex + 1)
    }
  }
}
//TODO
//extension UIScrollView {
//  enum Position {
//    case top
//    case bottom
//    case left
//    case right
//  }
//}
