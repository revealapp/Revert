//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  private let countries = CollectableCollection<Country>(resourceFileName: "CountriesCapitals")
  private let cellConfigurator = CountryCellConfigurator()
}

// MARK : UITableViewDataSource

extension TableViewController: UITableViewDataSource {
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.countries.countOfGroups
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.countries[section].countOfRows
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.countries[section].title
  }
  
  override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    let count = self.countries[section].countOfRows
    return NSString(format: NSLocalizedString("tableviewcontroller.footer", comment: "TableViewController footer title"), count) as String
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(SB.Cell.TableViewController) as! UITableViewCell
    let country = self.countries.itemAtIndexPath(indexPath)
    
    self.cellConfigurator.configureCell(cell, withCountry: country)
    return cell
  }
  
  override func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
    return self.countries.groups.map({$0.title!})
  }
}

// MARK : UITableViewDelegate

extension TableViewController: UITableViewDelegate {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}
