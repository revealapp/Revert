//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class AlertViewController: RevertTableViewController {

  required init?(coder aDecoder: NSCoder) {
    self.dataSource = DataSource(
      collection: self.collection,
      configureCell: type(of: self).configureCell,
      cellIdentifier: Storyboards.Cell.Alert
    )

    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.dataSource = self.dataSource
  }

  fileprivate var collection = CollectableCollection<Item>(items: .Alert)
  fileprivate var dataSource: DataSource<Item, BasicCell>
}

// MARK: - UIAlertController Presenter
extension AlertViewController {

  fileprivate func displayAlertControllerForWithStyle(_ style: UIAlertControllerStyle, fromView: UIView) {
    let alertViewController = UIAlertController.exampleAlertControllerWithStyle(style)
    alertViewController.popoverPresentationController?.sourceView = fromView
    self.present(alertViewController, animated: true, completion: nil)
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

    fileprivate func displayCorrespondingAlertForIdentifier(_ identifier: Identifier, fromView: UIView) {
      switch identifier {
      case .AlertView:
        AlertViewController.showExampleAlertView()
      case .ActionSheet:
        AlertViewController.showExampleActionsSheetInView(fromView)
      default:
        let alertStyle: UIAlertControllerStyle = identifier == .AlertController ? .alert : .actionSheet
        self.displayAlertControllerForWithStyle(alertStyle, fromView: fromView)
      }
    }
  }
#endif

#if os(tvOS)

  extension AlertViewController {

    fileprivate func displayCorrespondingAlertForIdentifier(_ identifier: Identifier, fromView: UIView) {
      let alertStyle: UIAlertControllerStyle = identifier == .AlertController ? .alert : .actionSheet
      self.displayAlertControllerForWithStyle(alertStyle, fromView: fromView)
    }
  }
#endif

// MARK: - UITableViewDelegate
extension AlertViewController {

  @available(iOS 9.0, *)
  override func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
    if let nextFocusedIndexPath = context.nextFocusedIndexPath {
      self.tableView.selectRow(at: nextFocusedIndexPath, animated: true, scrollPosition: .none)
    }
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = self.collection[indexPath]

    guard
      let cell = tableView.cellForRow(at: indexPath),
      let identifier = Identifier(rawValue: item.cellIdentifier)
    else {
      fatalError("Unknown cellIdentifier or cell")
    }

    self.displayCorrespondingAlertForIdentifier(identifier, fromView: cell)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension AlertViewController {

  static func configureCell(_ cell: BasicCell, object: Item) {
    cell.titleLabel.text = object.title
  }
}
