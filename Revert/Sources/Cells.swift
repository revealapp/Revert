//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class MasterCell: UITableViewCell {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
}

final class CountryCell: UITableViewCell {
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
}

final class StressCell: UICollectionViewCell {
  private func setupSubviews() {
    var currentView: UIView = self
    
    for var i = 0; i < 5; ++i {
      let subView = UIView()
      
      subView.setTranslatesAutoresizingMaskIntoConstraints(false)
      
      currentView.addSubview(subView)
      currentView.addConstraints(self.dynamicType.constraintsForSubView(subView))
      currentView = subView
    }
  }
  
  private class func constraintsForSubView(subView: UIView) -> [NSLayoutConstraint] {
    let bindingViews = ["subView": subView]
    let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
      "H:|[subView]|",
      options: NSLayoutFormatOptions(0),
      metrics: nil,
      views: bindingViews) as! [NSLayoutConstraint]
    let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
      "V:|[subView]|",
      options: NSLayoutFormatOptions(0),
      metrics: nil,
      views: bindingViews) as! [NSLayoutConstraint]
    
    return horizontalConstraints + verticalConstraints
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.setupSubviews()
  }
}