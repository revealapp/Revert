//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class SuperDeepViewController: ViewController {
  @IBOutlet weak var containerView: UIView!
  
  private var wasSetup = false
  private var colors: [UIColor] {
    return [UIColor.revertDarkblueColor(), UIColor.revertOrangeColor(), UIColor.revertPinkColor()]
  }
  
  private func colorForIndex(index: Int) -> UIColor {
    if index % 5 == 0 {
      return self.colors[(index / 5) % 3]
    }
    return UIColor.whiteColor()
  }
  
  private var maxTopBottomLayoutLength: CGFloat {
    if let tabBarHeight = self.tabBarController?.tabBar.bounds.height {
      return tabBarHeight
    }
    return self.navigationController?.navigationBar.bounds.height ?? 0.0
  }

  private func setupPyramidSubviewsIfNecessary() {
    // Only perform this action once
    if self.wasSetup {
      return
    }
    self.wasSetup = true
    
    let spacing: CGFloat = 5.0
    var currentView = self.containerView
    var width = min(self.view.bounds.height, self.view.bounds.width) - self.maxTopBottomLayoutLength
    
    for var i = 0; width > 2.0 * spacing; width -= spacing + spacing {
      let subView = UIView()
      subView.backgroundColor = self.colorForIndex(i).colorWithAlphaComponent(0.5)
      subView.setTranslatesAutoresizingMaskIntoConstraints(false)
      
      currentView.addSubview(subView)
      currentView.addConstraints(self.dynamicType.constraintsForSubView(subView, spacing: spacing))
      currentView = subView
      ++i
    }

    currentView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.75)
    self.view.layoutIfNeeded()
  }
  
  private class func constraintsForSubView(subView: UIView, spacing: CGFloat) -> [NSLayoutConstraint] {
    let bindingViews = ["subView": subView]
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

    return horizontalConstraints + verticalConstraints
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    self.setupPyramidSubviewsIfNecessary()
  }
}

