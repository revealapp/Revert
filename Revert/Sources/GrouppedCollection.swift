//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

protocol Collectable {
  init(dictionary: [String: AnyObject])
}

struct CollectableGroup<T: Collectable> {
  internal let rows: [T]
  internal let title: String?
  
  init(dictionary: [String: AnyObject]) {
    self.title = dictionary["title"] as? String
    self.rows = (dictionary["rows"] as! [[String: AnyObject]]).map({T(dictionary: $0)})
  }
  
  internal subscript(i: Int) -> T {
    return self.rows[i]
  }
  
  internal var countOfRows: Int {
    return self.rows.count
  }
}

struct CollectableCollection<T: Collectable> {
  internal let groups: [CollectableGroup<T>]
  
  init(resourceFilename: String) {
    self.groups = self.dynamicType.collectableItemsFromRessource(resourceFilename)
  }
  
  internal subscript(i: Int) -> CollectableGroup<T> {
    return self.groups[i]
  }
  
  internal var countOfGroups: Int {
    return self.groups.count
  }
  
  internal func itemAtIndexPath(indexPath: NSIndexPath) -> T {
    return self[indexPath.section][indexPath.row]
  }
  
  private static func collectableItemsFromRessource(resourceFilename: String) -> [CollectableGroup<T>] {
    let items = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource(resourceFilename, ofType: "plist")!) as! [[String: AnyObject]]
    return items.map({CollectableGroup<T>(dictionary: $0)})
  }
}
