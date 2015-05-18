//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import GLKit

private extension UIViewController {
  func prepareForInfoSegue(segue: UIStoryboardSegue, item: HomeItem) {
    let destinationNavigationController = segue.destinationViewController as! UINavigationController
    let destinationViewController = destinationNavigationController.topViewController as! SettableHomeItem
    destinationViewController.item = item
  }
}

class RevertViewController: UIViewController, SettableHomeItem {
  var item: HomeItem?
  
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
  var item: HomeItem?
  
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
  var item: HomeItem?
  
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

class RevertGLKViewController: GLKViewController, SettableHomeItem {
  var item: HomeItem?
  
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