//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit
import WebKit

final class WebViewController: RevertViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    if NSClassFromString("WKWebView") == nil {
      self.navigationItem.titleView = nil
      self.navigationItem.title = NSLocalizedString("WebView", comment: "WebView title")
    }

    self.setupWebView(self.uiWebView)
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    self.topConstraint?.constant = self.currentWebView?.isKind(of: UIWebView.self) == true ? -self.topLayoutGuide.length : 0
  }

  // MARK: Private

  private enum WebViewType: Int {
    case uiWebView = 0
    case wkWebView = 1
  }

  private let request = URLRequest(url: Bundle.main.revealWebsiteURL)
  private var currentWebView: UIView?
  private var topConstraint: NSLayoutConstraint?

  private lazy var uiWebView: UIWebView = {
    let webView = UIWebView()
    webView.delegate = self
    webView.loadRequest(self.request)
    return webView
  }()

  private lazy var wkWebView: WKWebView = {
    let webView = WKWebView()
    webView.navigationDelegate = self
    webView.load(self.request)
    return webView
  }()

  @IBAction private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    let nextWebView = sender.selectedSegmentIndex == WebViewType.uiWebView.rawValue ? self.uiWebView : self.wkWebView
    self.currentWebView?.removeFromSuperview()
    self.setupWebView(nextWebView)
  }

  private func setupWebView(_ webView: UIView) {
    webView.translatesAutoresizingMaskIntoConstraints = false

    let leftConstraint = NSLayoutConstraint(item: webView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
    let rightConstraint = NSLayoutConstraint(item: webView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
    let bottomConstraint = NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
    let topConstraint = NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)

    self.currentWebView = webView
    self.view.addSubview(webView)
    self.view.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    self.topConstraint = topConstraint
  }

  private func showFailAlert() {
    let alertViewController = UIAlertController(
      title: NSLocalizedString("Error", comment: "Alert title on content failed loading"),
      message: NSLocalizedString("Failed to load content. Make sure you're connected to the internet and try again.", comment: "Alert message on content failed loading"),
      preferredStyle: .alert
    )

    alertViewController.addAction(UIAlertAction(
      title: NSLocalizedString("Ok", comment: "Alert dismiss button on content failed loading"),
      style: .cancel,
      handler: nil)
    )

    alertViewController.popoverPresentationController?.sourceView = self.view
    self.present(alertViewController, animated: true, completion: nil)
  }
}

// MARK: - UIWebViewDelegate
extension WebViewController: UIWebViewDelegate {

  func webViewDidStartLoad(_ webView: UIWebView) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func webViewDidFinishLoad(_ webView: UIWebView) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {

  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    self.showFailAlert()
  }

  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    self.showFailAlert()
  }
}
