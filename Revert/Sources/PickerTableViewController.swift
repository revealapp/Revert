// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import UIKit

final class PickerTableViewController: UITableViewController {
  private enum Section: CaseIterable {
    case datePicker
    case colorPicker
    case other
  }

  private let sections: [CountrySection] = RevertItems.capitalCities.data()
  private let datePickerCellIdentifier = "DatePickerCell"
  private let tableViewCellIdentifier = "UITableViewCell"

  private var pickerSections: [Section] {
    if #available(iOS 14.0, *) {
      return [.datePicker, .colorPicker, .other]
    }
    return [.datePicker, .other]
  }

  @available(iOS 14, *)
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
      return pickerSections[section] == .datePicker ? datePickerStyles.count : 1
    }
    return 1
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    switch pickerSections[indexPath.section] {
    case .datePicker:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: datePickerCellIdentifier) as? DatePickerTableViewCell else {
        fatalError("Expecting to dequeue a \(DatePickerTableViewCell.self) from the table view")
      }

      if #available(iOS 14.0, *) {
        cell.datePicker.preferredDatePickerStyle = datePickerStyles[indexPath.row]
      }

      return cell
    case .other:
      let identifier = "CountriesPickerCell"
      let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!

      return cell
    case .colorPicker:
      let cell = UITableViewCell(style: .subtitle, reuseIdentifier: tableViewCellIdentifier)
      cell.textLabel?.text = "Color Picker"
      cell.detailTextLabel?.text = "Tap here to launch the new color picker from iOS 14"

      if #available(iOS 14.0, *) {
        cell.detailTextLabel?.textColor = .secondaryLabel
      }

      return cell
    }
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard pickerSections[indexPath.section] == .colorPicker else {
      return
    }

    if #available(iOS 14.0, *) {
      let colorPickerController = UIColorPickerViewController()

      self.navigationController?.present(colorPickerController, animated: true, completion: nil)
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
