// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import Foundation

final class AppExtensionViewController: RevertViewController {

  @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
    guard let image = UIImage(named: "info_icon") else { return }

    let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    present(activityViewController, animated: true, completion: nil)
  }
}
