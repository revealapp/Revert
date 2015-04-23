//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class StressTestViewController: UIViewController {

  private var wasSetup = false

  private func setupPyramidSubviewsIfNecessary() {
    // Only perform this action once
    if self.wasSetup {
      return
    }
    self.wasSetup = true
    
    let spacing: CGFloat = 5.0
    let doubleSpacing = spacing * 2.0
    var currentView = self.view
    var width = min(currentView.bounds.height, currentView.bounds.width) - self.topLayoutGuide.length - self.bottomLayoutGuide.length
    
    while width > doubleSpacing {
      let subView = UIView()
      let bindingViews = ["subView": subView]
      
      subView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(doubleSpacing / (width - doubleSpacing))
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
      width -= doubleSpacing
    }
    self.view.layoutIfNeeded()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    self.setupPyramidSubviewsIfNecessary()
  }
}
