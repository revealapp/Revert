// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import UIKit

final class PickerTableViewController: UITableViewController {
  private let sections: [CountrySection] = RevertItems.capitalCities.data()
  private let datePickerCellIdentifier = "DatePickerCell"

  private enum Section: Int, CaseIterable {
    case datePicker = 0
    case other = 1
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UINib(nibName: "DatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: datePickerCellIdentifier)
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return Section.allCases.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if #available(iOS 14.0, *) {
      return section == Section.datePicker.rawValue ? 3 : 1
    }
    return 1
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == Section.other.rawValue,
       let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesPickerCell") {
      return cell
    }

    guard let cell = tableView.dequeueReusableCell(withIdentifier: datePickerCellIdentifier) as? DatePickerTableViewCell else {
      fatalError("Expecting to dequeue a \(DatePickerTableViewCell.self) from the table view")
    }

    if #available(iOS 14.0 , *) {
      let datePickerStyles: [UIDatePickerStyle] = [.compact, .inline, .wheels]
      cell.datePicker.preferredDatePickerStyle = datePickerStyles[indexPath.row]
    }

    return cell
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
