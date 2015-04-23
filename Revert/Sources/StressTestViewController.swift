//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class StressTestViewController: UIViewController {
  @IBOutlet weak var containerView: UIView!
  
  private func setupSubviews() {
    let spacing: CGFloat = 2.0
    let doubleSpacing = spacing * 2.0
    var currentView = self.containerView
    
    for var i = min(self.view.bounds.height, self.view.bounds.width); i > doubleSpacing; i -= doubleSpacing {
      let subView = UIView()
      let bindingViews = ["subView": subView]
      
      subView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(doubleSpacing / (i - doubleSpacing))
      subView.setTranslatesAutoresizingMaskIntoConstraints(false)
      currentView.addSubview(subView)
      
      let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
        "H:|-\(spacing)-[subView]-\(spacing)-|",
        options: NSLayoutFormatOptions(0),
        metrics: nil,
        views: bindingViews) as! [NSLayoutConstraint]
      let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|-\(spacing)-[subView]-\(spacing)-|",
        options: NSLayoutFormatOptions(0),
        metrics: nil,
        views: bindingViews) as! [NSLayoutConstraint]
      
      currentView.addConstraints(horizontalConstraints + verticalConstraints)
      currentView = subView
    }
    self.view.layoutIfNeeded()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupSubviews()
  }
}
