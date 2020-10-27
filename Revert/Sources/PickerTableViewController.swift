// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import UIKit
import PhotosUI

final class PickerTableViewController: RevertTableViewController {
  private enum Section: CaseIterable {
    case datePicker
    case iOS14Picker
    case other
  }

  private let sections: [CountrySection] = RevertItems.capitalCities.data()
  private let datePickerCellIdentifier = "DatePickerCell"
  private let tableViewCellIdentifier = "UITableViewCell"
  private let tableViewCelllabels: [(title: String, subtitle: String)] = [
    (title: "Color Picker", subtitle: "Tap here to launch the new color picker from iOS 14"),
    (title: "Photo Picker", subtitle: "Tap here to launch the new photo picker from iOS 14"),
  ]

  private var pickerSections: [Section] {
    if #available(iOS 14.0, *) {
      return [.datePicker, .iOS14Picker, .other]
    }
    return [.datePicker, .other]
  }

  @available(iOS 14.0, *)
  var datePickerStyles: [UIDatePickerStyle] { [.compact, .inline, .wheels] }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.register(UINib(nibName: "DatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: datePickerCellIdentifier)
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return self.pickerSections.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if #available(iOS 14.0, *) {
      switch pickerSections[section] {
      case .datePicker:
        return self.datePickerStyles.count
      case .iOS14Picker:
        return tableViewCelllabels.count
      default:
        return 1
      }
    }
    return 1
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    switch pickerSections[indexPath.section] {
    case .datePicker:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: self.datePickerCellIdentifier) as? DatePickerTableViewCell else {
        fatalError("Expecting to dequeue a \(DatePickerTableViewCell.self) from the table view")
      }

      if #available(iOS 14.0, *) {
        cell.datePicker.preferredDatePickerStyle = self.datePickerStyles[indexPath.row]
      }

      return cell
    case .other:
      let identifier = "CountriesPickerCell"
      let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!

      return cell
    case .iOS14Picker:
      let cell = UITableViewCell(style: .subtitle, reuseIdentifier: self.tableViewCellIdentifier)

      cell.textLabel?.text = tableViewCelllabels[indexPath.row].title
      cell.detailTextLabel?.text = tableViewCelllabels[indexPath.row].subtitle

      if #available(iOS 14.0, *) {
        cell.detailTextLabel?.textColor = .secondaryLabel
      }

      return cell
    }
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard self.pickerSections[indexPath.section] == .iOS14Picker else {
      return
    }

    if #available(iOS 14.0, *) {
      let controller: UIViewController

      if indexPath.row == 1 {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 3
        let photoPicker = PHPickerViewController(configuration: configuration)
        photoPicker.delegate = self
        controller = photoPicker
      } else {
        controller = UIColorPickerViewController()
      }

      self.navigationController?.present(controller, animated: true, completion: nil)
    }

    self.tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: - UIPickerViewDataSource
extension PickerTableViewController: UIPickerViewDataSource {

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.sections[component].rows.count
  }
}

// MARK: - UIPickerViewDelegate
extension PickerTableViewController: UIPickerViewDelegate {

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return self.sections.first?.rows[row].name
  }
}

// MARK: - PHPickerViewControllerDelegate
@available(iOS 14.0, *)
extension PickerTableViewController: PHPickerViewControllerDelegate {
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    dismiss(animated: true, completion: nil)
  }
}
