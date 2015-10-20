//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class CountriesDataSource: NSObject, UITableViewDataSource {
  private let collection: CollectableCollection<Country>
  private let cellConfigurator: CountryCellConfigurator
  
  required init(collection: CollectableCollection<Country>, cellConfigurator: CountryCellConfigurator) {
    self.collection = collection
    self.cellConfigurator = cellConfigurator
    
    super.init()
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.collection.countOfItems
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.collection[section].countOfItems
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier(SB.Cell.TableViewController) as? BasicCell else {
      fatalError("Expecting to dequeue a `BasicCell` from the tableView")
    }

    let country = self.collection[indexPath]
    self.cellConfigurator.configureCell(cell, withCountry: country)
    return cell
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.collection[section].title
  }
  
  func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    let count = self.collection[section].countOfItems
    return NSString(format: NSLocalizedString("%lu Countries", comment: ""), count) as String
  }
  
  func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
    return self.collection.items.map { $0.title ?? "" }
  }
}