//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class AlertViewController: RevertTableViewController {
  private var collection = CollectableCollection<Item>(items: .Alert)
  private var dataSource: DataSource<Item, BasicCell>

  private enum Identifier: String {
    case AlertView = "alertview"
    case ActionSheet = "actionsheet"
    case AlertController = "alertcontroller"
    case ActionController = "actioncontroller"
  }

  required init?(coder aDecoder: NSCoder) {
    self.dataSource = DataSource(
      collection: self.collection,
      configureCell: self.dynamicType.configureCell,
      cellIdentifier: SB.Cell.Alert
    )

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource = self.dataSource
  }
}

// MARK: Presenters
extension AlertViewController {
  @available(iOS 8.0, *)
  private func displayAlertControllerForWithStyle(style: UIAlertControllerStyle, fromView: UIView) {
    let alertViewController = UIAlertController.exampleAlertControllerWithStyle(style)
    alertViewController.popoverPresentationController?.sourceView = fromView
    self.presentViewController(alertViewController, animated: true, completion: nil)
  }

  private func displayCorrespondingAlertForIdentifier(identifier: Identifier, fromView: UIView) {
    switch identifier {
    case .AlertView:
      UIAlertView.exampleAlertView().show()
    case .ActionSheet:
      UIActionSheet.exampleActionSheet().showInView(fromView)
    default:
      if #available(iOS 8.0, *) {
        let alertStyle: UIAlertControllerStyle = identifier == .AlertController ? .Alert : .ActionSheet
        self.displayAlertControllerForWithStyle(alertStyle, fromView: fromView)
      }
    }
  }
}

// MARK: UITableViewDelegate
extension AlertViewController {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let item = self.collection[indexPath]

    guard let cell = tableView.cellForRowAtIndexPath(indexPath),
      identifier = Identifier(rawValue: item.cellIdentifier) else {
      fatalError("Unknown cellIdentifier or cell")
    }

    self.displayCorrespondingAlertForIdentifier(identifier, fromView: cell)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

extension AlertViewController {
  static func configureCell(cell: BasicCell, object: Item) {
    cell.titleLabel.text = object.title
  }
}
