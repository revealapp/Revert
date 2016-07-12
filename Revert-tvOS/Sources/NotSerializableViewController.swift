//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

final class NonSerializableViewController: RevertViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    self.infSpacingStackView.spacing = 1/0
    self.nanSpacingStackView.spacing = 0/0
  }

  // Mark: Private
  @IBOutlet private var infSpacingStackView: UIStackView!
  @IBOutlet private var nanSpacingStackView: UIStackView!
}
