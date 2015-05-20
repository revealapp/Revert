//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import GLKit

private extension UIViewController {
  func prepareForInfoSegue(segue: UIStoryboardSegue, item: HomeItem) {
    if let destinationNavigationController = segue.destinationViewController as? UINavigationController,
      destinationViewController = destinationNavigationController.topViewController as? SettableHomeItem {
        destinationViewController.item = item
    } else {
      fatalError("Destination view controller isn't a NavigationController or its topViewController doesn't conform to SettableHomeItem")
    }
  }
}

class RevertViewController: UIViewController, SettableHomeItem {
  final var item: HomeItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    if segue.identifier == SB.Segue.Info {
      self.prepareForInfoSegue(segue, item: self.item!)
    }
  }
}

class RevertTableViewController: UITableViewController, SettableHomeItem {
  final var item: HomeItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    if segue.identifier == SB.Segue.Info {
      self.prepareForInfoSegue(segue, item: self.item!)
    }
  }
}

class RevertCollectionViewController: UICollectionViewController, SettableHomeItem {
  final var item: HomeItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    if segue.identifier == SB.Segue.Info {
      self.prepareForInfoSegue(segue, item: self.item!)
    }
  }
}
