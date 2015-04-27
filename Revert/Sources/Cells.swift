//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class MasterCell: UITableViewCell {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    // Programatically adding subtitleLabel.baseline = iconView.bottom as these
    // constraints cannot be added from IB
    
    let subtitleBaselineConstraint = NSLayoutConstraint(
      item: self.iconImageView,
      attribute: .Bottom,
      relatedBy: .Equal,
      toItem: self.subtitleLabel,
      attribute: .Baseline,
      multiplier: 1.0,
      constant: 0.0)

    self.addConstraint(subtitleBaselineConstraint)
  }
}

class CountryCell: UITableViewCell {
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
}

class StressCell: UICollectionViewCell {
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