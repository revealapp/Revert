//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

struct MasterItem {
  internal let title: String
  internal let subtitle: String
  internal let iconName: String
  internal let storyboardIdentifier: String
  internal let isPush: Bool
  
  init(dictionary: [String: AnyObject]) {
    self.title = dictionary["title"] as! String
    self.subtitle = dictionary["subtitle"] as! String
    self.iconName = dictionary["iconName"] as! String
    self.storyboardIdentifier = dictionary["storyboardIdentifier"] as! String
    self.isPush = dictionary["isPush"] as! Bool
  }
}

struct MasterItemCollection {
  internal let groups: [[MasterItem]]
  
  init() {
    self.groups = self.dynamicType.loadItems()
  }
  
  var countOfGroups: Int {
    return self.groups.count
  }
  
  func countOfItemsInGroup(section: Int) -> Int {
    return self.groups[section].count
  }
  
  func itemAtIndexPath(indexPath: NSIndexPath) -> MasterItem {
    return self.groups[indexPath.section][indexPath.row]
  }

  private static func loadItems() -> [[MasterItem]] {
    let items = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("MasterItems", ofType: "plist")!) as! [[[String: AnyObject]]]
    return items.map({$0.map({MasterItem(dictionary: $0)})})
  }
}
