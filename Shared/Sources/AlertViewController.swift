//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class AlertViewController: RevertTableViewController {
  required init?(coder aDecoder: NSCoder) {
    self.dataSource = DataSource(
      collection: self.collection,
      configureCell: self.dynamicType.configureCell,
      cellIdentifier: Storyboards.Cell.Alert
    )

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource = self.dataSource
  }

  private var collection = CollectableCollection<Item>(items: .Alert)
  private var dataSource: DataSource<Item, BasicCell>
}

// MARK:- UIAlertController Presenter
extension AlertViewController {
  private func displayAlertControllerForWithStyle(style: UIAlertControllerStyle, fromView: UIView) {
    let alertViewController = UIAlertController.exampleAlertControllerWithStyle(style)
    alertViewController.popoverPresentationController?.sourceView = fromView
    self.presentViewController(alertViewController, animated: true, completion: nil)
  }
}

private enum Identifier: String {
  case AlertController = "alertcontroller"
  case ActionController = "actioncontroller"

  #if os(iOS)
  case AlertView = "alertview"
  case ActionSheet = "actionsheet"
  #endif
}

#if os(iOS)
  extension AlertViewController {
    private func displayCorrespondingAlertForIdentifier(identifier: Identifier, fromView: UIView) {
      switch identifier {
      case .AlertView:
        AlertViewController.showExampleAlertView()
      case .ActionSheet:
        AlertViewController.showExampleActionsSheetInView(fromView)
      default:
        let alertStyle: UIAlertControllerStyle = identifier == .AlertController ? .Alert : .ActionSheet
        self.displayAlertControllerForWithStyle(alertStyle, fromView: fromView)
      }
    }
  }
#endif

#if os(tvOS)
  extension AlertViewController {
    private func displayCorrespondingAlertForIdentifier(identifier: Identifier, fromView: UIView) {
      let alertStyle: UIAlertControllerStyle = identifier == .AlertController ? .Alert : .ActionSheet
      self.displayAlertControllerForWithStyle(alertStyle, fromView: fromView)
    }
  }
#endif

// MARK:- UITableViewDelegate
extension AlertViewController {
  @available(iOS 9.0, *)
  override func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
    if let nextFocusedIndexPath = context.nextFocusedIndexPath {
      self.tableView.selectRowAtIndexPath(nextFocusedIndexPath, animated: true, scrollPosition: .None)
    }
  }

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
