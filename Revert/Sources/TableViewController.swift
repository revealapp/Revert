//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  private let collection = CollectableCollection<Country>(resourceFilename: "CountriesCapitals")
  private let cellConfigurator = CountryCellConfigurator()
  private let dataSource: CountryDataSource
  
  required init!(coder aDecoder: NSCoder!) {
    self.dataSource = CountryDataSource(collection: self.collection, cellConfigurator: self.cellConfigurator)
    
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self.dataSource
  }
}

// MARK : UITableViewDelegate

extension TableViewController: UITableViewDelegate {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}
