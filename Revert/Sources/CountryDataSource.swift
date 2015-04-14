//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class CountryDataSource: NSObject, UITableViewDataSource {
  private let collection: CollectableCollection<Country>
  private let cellConfigurator: CountryCellConfigurator
  
  required init(collection: CollectableCollection<Country>, cellConfigurator: CountryCellConfigurator) {
    self.collection = collection
    self.cellConfigurator = cellConfigurator
    
    super.init()
  }
  
  internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.collection.countOfGroups
  }
  
  internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.collection[section].countOfRows
  }
  
  internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(SB.Cell.TableViewController) as! CountryCell
    let country = self.collection.itemAtIndexPath(indexPath)
    
    self.cellConfigurator.configureCell(cell, withCountry: country)
    return cell
  }
  
  internal func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.collection[section].title
  }
  
  internal func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    let count = self.collection[section].countOfRows
    return NSString(format: NSLocalizedString("tableviewcontroller.footer", comment: "TableViewController footer title"), count) as String
  }
  
  internal func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
    return self.collection.groups.map({$0.title!})
  }
}