//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: UITableViewDataSource
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 5
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return NSString(format: NSLocalizedString("tableviewcontroller.header", comment: "TableViewController header title"), section) as String
  }
  
  override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return NSString(format: NSLocalizedString("tableviewcontroller.footer", comment: "TableViewController footer title"), section) as String
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(SB.Cell.TableViewController) as! UITableViewCell
    cell.textLabel!.text = NSString(format: NSLocalizedString("tableviewcontroller.cell.title", comment: "TableViewController cell title"), indexPath.row) as String
    cell.detailTextLabel!.text = NSString(format: NSLocalizedString("tableviewcontroller.cell.subtitle", comment: "TableViewController cell title"), indexPath.row) as String
    return cell
  }
  
  // MARK : UITableViewDelegate
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}
