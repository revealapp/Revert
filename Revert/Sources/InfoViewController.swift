//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class InfoViewController: UIViewController, SettableHomeItem {
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var webView: UIWebView!
  @IBOutlet private weak var titleLabel: UILabel!
  
  var item: HomeItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Configure the view
    if let item = self.item {
      self.imageView.image = UIImage(named: item.iconName)
      self.titleLabel.text = item.title
      
      let htmlString = HTMLWithContent(item.infoFilename)
      self.webView.loadHTMLString(htmlString, baseURL: nil)
    } else {
      fatalError("Item should be set before viewDidLoad")
    }
  }
  
  @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
    self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
  }
}

extension InfoViewController: UIWebViewDelegate {
  func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    if let URL = request.URL where URL != NSURL(string: "about:blank") {
      UIApplication.sharedApplication().openURL(URL)
      return false
    }
    return true
  }
}
