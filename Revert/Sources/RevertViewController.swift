//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit
import GLKit

private extension UIViewController {
  func prepareForInfoSegue(segue: UIStoryboardSegue, item: HomeItem?) {
    guard let destinationNavigationController = segue.destinationViewController as? UINavigationController,
      destinationViewController = destinationNavigationController.topViewController as? SettableHomeItem else {
        fatalError("Destination view controller isn't a `UINavigationController` or its `topViewController` doesn't conform to `SettableHomeItem`")
    }

    guard let item = item else {
      fatalError("There should be an item present")
    }

    destinationViewController.item = item
  }
}

// MARK: UIViewController
class RevertViewController: UIViewController, SettableHomeItem {
  final var item: HomeItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    if segue.identifier == SB.Segue.Info {
      self.prepareForInfoSegue(segue, item: self.item)
    }
  }
}

// MARK: UITableViewController
class RevertTableViewController: UITableViewController, SettableHomeItem {
  final var item: HomeItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    if segue.identifier == SB.Segue.Info {
      self.prepareForInfoSegue(segue, item: self.item)
    }
  }
}

// MARK: UICollectionViewController
class RevertCollectionViewController: UICollectionViewController, SettableHomeItem {
  final var item: HomeItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    if segue.identifier == SB.Segue.Info {
      self.prepareForInfoSegue(segue, item: self.item)
    }
  }
}

// MARK: GLKViewController
class RevertGLKViewController: GLKViewController, SettableHomeItem {
  final var item: HomeItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    if segue.identifier == SB.Segue.Info {
      self.prepareForInfoSegue(segue, item: self.item)
    }
  }
}
