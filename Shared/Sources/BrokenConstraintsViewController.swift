//
//  BrokenConstraintsViewController.swift
//  Revert-iOS
//
//  Created by june chen on 20/6/19.
//  Copyright © 2019 Itty Bitty Apps. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
final class BrokenConstraintsViewController: RevertViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.makeBrokenLayoutGuide()
  }

  // MARK: Private

  @IBOutlet private weak var blueViewWidth: NSLayoutConstraint!

  private func makeBrokenLayoutGuide() {
    let guide = UILayoutGuide()
    guide.identifier = "brokenLayoutGuide"

    self.view.addLayoutGuide(guide)

    guide.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
    guide.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    guide.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

  }

  @IBAction func breakBlueViewButtonTapped(_ sender: Any) {
    self.blueViewWidth.constant = 0
  }
}
