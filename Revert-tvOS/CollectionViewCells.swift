//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit

class CollectionViewCell: UICollectionViewCell {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  required override init(frame: CGRect) {
    print(frame)
    super.init(frame: frame)
    
    self.applyDynamicType()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.applyDynamicType()
  }
  
  func applyDynamicType(notification: NSNotification? = nil) {
    self.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
  }
  
  // MARK: Private
  @IBOutlet private(set) weak var titleLabel: UILabel!
}

final class HomeCollectionCell: CollectionViewCell {
  override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
    super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
    
    coordinator.addCoordinatedAnimations({
      if self.focused {
        self.titleLabel.textColor = UIColor.whiteColor()
      } else {
        self.titleLabel.textColor = UIColor.blackColor()
      }
    }, completion: nil)
  }
  
  // MARK: Private
  @IBOutlet private(set) weak var imageView: UIImageView!
}
