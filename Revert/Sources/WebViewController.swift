//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let webView = self.dynamicType.loadedWebView()
    webView.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.view.addSubview(webView)
    self.view.addConstraints(self.dynamicType.constraintsForWebView(webView))
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
  
  private class func loadedWebView() -> UIView {
    let req = NSURLRequest(URL: NSURL(string: "http://www.revealapp.com")!)
    
    if let _ = NSClassFromString("WKWebView") {
      let webView = WKWebView()
      webView.loadRequest(req)
      return webView
    } else {
      let webView = UIWebView()
      webView.loadRequest(req)
      return webView
    }
  }
}
