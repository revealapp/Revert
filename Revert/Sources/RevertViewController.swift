//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import GLKit

private extension UIViewController {
  func prepareForInfoSegue(segue: UIStoryboardSegue, item: MasterItem) {
    let destinationNavigationController = segue.destinationViewController as! UINavigationController
    let destinationViewController = destinationNavigationController.topViewController as! SettableMasterItem
    destinationViewController.item = item
  }
}

class ViewController: UIViewController, SettableMasterItem {
  var item: MasterItem?
  
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

class TableViewController: UITableViewController, SettableMasterItem {
  var item: MasterItem?
  
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

class CollectionViewController: UICollectionViewController, SettableMasterItem {
  var item: MasterItem?
  
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

class OGLViewController: GLKViewController, SettableMasterItem {
  var item: MasterItem?
  
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