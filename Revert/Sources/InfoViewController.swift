//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class InfoViewController: UIViewController, SettableHomeItem {
  var item: HomeItem?

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let item = self.item else {
      fatalError("Item should be set before `-viewDidLoad`")
    }

    guard let infoFilename = item.infoFilename else {
      fatalError("Cannot display without a valid info filename")
    }

    // Configure the view
    self.imageView.image = UIImage(named: item.iconName)
    self.titleLabel.text = item.title

    let htmlString = infoHTMLWithContent(infoFilename)
    self.webView.loadHTMLString(htmlString, baseURL: nil)
  }

  // MARK: Private

  @IBOutlet fileprivate weak var imageView: UIImageView!
  @IBOutlet fileprivate weak var webView: UIWebView!
  @IBOutlet fileprivate weak var titleLabel: UILabel!

  @IBAction fileprivate func dismiss(_ sender: UIBarButtonItem) {
    self.presentingViewController?.dismiss(animated: true, completion: nil)
  }
}

// MARK: - UIWebViewDelegate
extension InfoViewController: UIWebViewDelegate {
  func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    if let URL = request.url, URL != Foundation.URL(string: "about:blank") {
      UIApplication.shared.openURL(URL)
      return false
    }
    return true
  }
}
