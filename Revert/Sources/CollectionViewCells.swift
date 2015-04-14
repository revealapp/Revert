//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class TextFieldControlCell: UICollectionViewCell {
  @IBAction func textFieldDidEndOnExit(sender: UITextField) {
    sender.resignFirstResponder()
  }
}

class TabBarCell: UICollectionViewCell {
  @IBOutlet weak var tabBar: UITabBar!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.tabBar.selectedItem = self.tabBar.items!.first! as? UITabBarItem
  }
}