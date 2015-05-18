//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

internal protocol Collectable {
  init(dictionary: [String: AnyObject])
}

struct CollectableGroup<T: Collectable> {
  let rows: [T]
  let title: String?
  
  init(dictionary: [String: AnyObject]) {
    self.title = dictionary["title"] as? String
    self.rows = (dictionary["rows"] as! [[String: AnyObject]]).map({T(dictionary: $0)})
  }
  
  subscript(i: Int) -> T {
    return self.rows[i]
  }
  
  var countOfRows: Int {
    return self.rows.count
  }
}

struct CollectableCollection<T: Collectable> {
  let groups: [CollectableGroup<T>]
  
  init(resourceFilename: String) {
    self.groups = self.dynamicType.collectableItemsFromRessource(resourceFilename)
  }
  
  subscript(i: Int) -> CollectableGroup<T> {
    return self.groups[i]
  }
  
  subscript(indexPath: NSIndexPath) -> T {
    return self.groups[indexPath.section][indexPath.row]
  }
  
  var countOfGroups: Int {
    return self.groups.count
  }
  
  private static func collectableItemsFromRessource(resourceFilename: String) -> [CollectableGroup<T>] {
    let items = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource(resourceFilename, ofType: "plist")!) as! [[String: AnyObject]]
    return items.map({CollectableGroup<T>(dictionary: $0)})
  }
}
