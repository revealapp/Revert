//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  private let req = NSURLRequest(URL: NSURL(string: "http://www.revealapp.com")!)

  
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  private lazy var uiWebView: UIWebView = {
    let webView = UIWebView()
    webView.delegate = self
    webView.loadRequest(self.req)
    return webView
    }()
  
  private lazy var wkWebView: WKWebView = {
    let webView = WKWebView()
    webView.navigationDelegate = self
    webView.loadRequest(self.req)
    return webView
  }()
  
  private var currentWebView: UIView?
  
  private enum WebView: Int {
    case UIWebView = 0
    case WKWebView = 1
  }
  
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

    if NSClassFromString("WKWebView") == nil {
      self.navigationItem.titleView = nil
      self.navigationItem.title = NSLocalizedString("WebView", comment: "WebView title")
    }
    
    self.setupWebView(self.uiWebView)
  }
  
  private func setupWebView(webView: UIView) {
    self.currentWebView = webView
    webView.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.view.addSubview(webView)
    self.view.addConstraints(self.dynamicType.constraintsForWebView(webView))
  }
  
  @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
    let nextWebView = sender.selectedSegmentIndex == WebView.UIWebView.rawValue ? self.uiWebView : self.wkWebView
    self.currentWebView!.removeFromSuperview()
    self.setupWebView(nextWebView)
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