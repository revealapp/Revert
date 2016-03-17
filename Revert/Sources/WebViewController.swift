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

  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)

    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    self.topConstraint?.constant = self.currentWebView?.isKindOfClass(UIWebView.self) == true ? -self.topLayoutGuide.length : 0
  }

  // MARK: Private

  private enum Type: Int {
    case UIWebView = 0
    case WKWebView = 1
  }

  private let request = NSURLRequest(URL: NSBundle.mainBundle().revealWebsiteURL)
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
    webView.loadRequest(self.request)
    return webView
  }()

  @IBAction private func segmentedControlValueChanged(sender: UISegmentedControl) {
    let nextWebView = sender.selectedSegmentIndex == Type.UIWebView.rawValue ? self.uiWebView : self.wkWebView
    self.currentWebView?.removeFromSuperview()
    self.setupWebView(nextWebView)
  }

  private func setupWebView(webView: UIView) {
    webView.translatesAutoresizingMaskIntoConstraints = false

    let leftConstraint = NSLayoutConstraint(item: webView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: 0)
    let rightConstraint = NSLayoutConstraint(item: webView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: 0)
    let bottomConstraint = NSLayoutConstraint(item: webView, attribute: .Bottom, relatedBy: .Equal, toItem: self.bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: 0)
    let topConstraint = NSLayoutConstraint(item: webView, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0)

    self.currentWebView = webView
    self.view.addSubview(webView)
    self.view.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    self.topConstraint = topConstraint
  }

  private func showFailAlert() {
    UIAlertView(
      title: NSLocalizedString("Error", comment: "Alert title on content failed loading"),
      message: NSLocalizedString("Failed to load content. Make sure you're connected to the internet an try again.", comment: "Alert message on content failed loading"),
      delegate: nil,
      cancelButtonTitle: NSLocalizedString("Ok", comment: "Alert dismiss button on content failed loading")
      ).show()
  }
}

// MARK:- UIWebViewDelegate
extension WebViewController: UIWebViewDelegate {
  func webViewDidStartLoad(webView: UIWebView) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
  }

  func webViewDidFinishLoad(webView: UIWebView) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
  }
}

// MARK:- WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
  func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
  }

  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
  }

  func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    self.showFailAlert()
  }

  func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    self.showFailAlert()
  }
}
