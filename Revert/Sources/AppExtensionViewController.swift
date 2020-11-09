// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import Foundation

final class AppExtensionViewController: RevertViewController {
  @IBOutlet var descriptionLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    descriptionLabel.text = " Tap the activity button and choose Revert App Extension activity item.\nThe App Extension will be launched and appears as a different connection when the screen is inspected in Reveal app"
  }

  @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
    guard let image = UIImage(named: "info_icon") else { return }

    let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    present(activityViewController, animated: true, completion: nil)
  }
}
