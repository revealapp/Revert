//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  private lazy var webView: UIView = {
    let req = NSURLRequest(URL: NSURL(string: "http://www.revealapp.com")!)
    if let _ = NSClassFromString("WKWebView") {
      let webView = WKWebView()
      webView.loadRequest(req)
      webView.navigationDelegate = self
      return webView
    } else {
      let webView = UIWebView()
      webView.loadRequest(req)
      webView.delegate = self
      return webView
    }
  }()
  
  private class func constraintsForWebView(webView: UIView) -> [NSLayoutConstraint] {
    let bindingViews = ["webView": webView]
    let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
      "H:|[webView]|",
      options: NSLayoutFormatOptions(0),
      metrics: nil,
      views: bindingViews) as! [NSLayoutConstraint]
    let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
      "V:|[webView]|",
      options: NSLayoutFormatOptions(0),
      metrics: nil,
      views: bindingViews) as! [NSLayoutConstraint]

    return horizontalConstraints + verticalConstraints
  }
  
  private func showFailAlert() {
    UIAlertView(
      title: NSLocalizedString("error", comment: "Alert title on content failed loading"),
      message: NSLocalizedString("webviewcontroller.alert.message", comment: "Alert message on content failed loading"),
      delegate: nil,
      cancelButtonTitle: NSLocalizedString("ok", comment: "Alert dismiss button on content failed loading")
    ).show()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.webView.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.view.addSubview(self.webView)
    self.view.addConstraints(self.dynamicType.constraintsForWebView(self.webView))
  }
}

// MARK: UIWebViewDelegate
extension WebViewController: UIWebViewDelegate {
  func webViewDidStartLoad(webView: UIWebView) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
  }
  
  func webViewDidFinishLoad(webView: UIWebView) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
  }
}

// MARK: WKNavigationDelegate
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